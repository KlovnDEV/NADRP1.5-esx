let ButtonsData = [];
let Buttons = [];
let Button = [];
let menuOpen = false;
const OpenMenu = (data) => {
    menuOpen = true;
    DrawButtons(data)
}

const CloseMenu = () => {
    for (let i = 0; i < ButtonsData.length; i++) {
        let id = ButtonsData[i].id
        $(".button").remove();
    }
    ButtonsData = [];
    Buttons = [];
    Button = [];
    menuOpen = false;
};

const DrawButtons = (data) => {
    ButtonsData = data
    for (let i = 0; i < ButtonsData.length; i++) {
        let header = ButtonsData[i].header
        let message = ButtonsData[i].txt
        let id = ButtonsData[i].id
        let disabled = ButtonsData[i].disabled
        let element
        if (!disabled) { 
            buttonClass = "button"
        } else {
            buttonClass = "button disabled"
        }
        element = $(`
            <div class="${buttonClass}" id=${id}>
              <div class="header" id=${id}>${header}</div>
              <div class="txt" id=${id}>${message}</div>
            </div>`
        );
        $('#buttons').append(element);
        Buttons[id] = element
        if (ButtonsData[i].params) {
            Button[id] = ButtonsData[i].params
            Button[id].disabled = ButtonsData[i].disabled
        }
    }
};

$(document).click(function(event){
    let $target = $(event.target);
    if ($target.closest('.button').length && $('.button').is(":visible")) {
        let id = event.target.id;
        if (!Button[id] || Button[id].disabled) return
        PostData(id)
    }
})

const PostData = (id) => {
    $.post(`https://nadrp-ui/dataPost`, JSON.stringify(Button[id]))
    return CloseMenu();
}

const CancelMenu = () => {
    $.post(`https://nadrp-ui/cancel`)
    return CloseMenu();
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const info = data.data
    const action = data.action
    switch (action) {
        case "OPEN_MENU":
            return OpenMenu(info);
        case "CLOSE_MENU":
            return CloseMenu();
        default:
        return;
    }
})


document.onkeyup = function(event) {
    event = event || window.event;
    var charCode = event.keyCode || event.which;
    if (charCode == 27 && menuOpen) {
        CancelMenu();
    }
};