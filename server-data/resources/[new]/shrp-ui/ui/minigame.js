let timer_start, timer_game, timer_finish, good_positions, wrong, right, speed;
let game_started = false;

const sleep = (ms, fn) => {return setTimeout(fn, ms)};
const range = (start, end, length = end - start + 1) => {
    return Array.from({length}, (_, i) => start + i)
}

const shuffle = (arr) => {
    for (let i = arr.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}

let positions = range(0, 35);
function listener(ev){
    if(!game_started) return;
    if( good_positions.indexOf( parseInt(ev.target.dataset.position) ) === -1 ){
        wrong++;
        ev.target.classList.add('bad');
    }else{
        right++;
        ev.target.classList.add('good');
    }
    ev.target.removeEventListener('click', listener);
    check();
}

function addListeners(){
    document.querySelectorAll('.group').forEach(el => {
        el.addEventListener('click', listener);
    });
}

function check(){
    if(wrong === 3){
        game_started = false;
        let blocks = document.querySelectorAll('.group');
        good_positions.forEach( pos => {
            blocks[pos].classList.add('proper');
        });
        setTimeout(() => {
            $.post(`https://shrp-ui/completeMinigame`, JSON.stringify({state: "lost"}))
            reset();
        }, 1500);
        return;
    }
    if(right === 14){
        $.post(`https://shrp-ui/completeMinigame`, JSON.stringify({state: "won"}))
        reset();
    }
}

function reset(){
    game_started = false;

    clearTimeout(timer_start);
    clearTimeout(timer_game);
    clearTimeout(timer_finish);
    $('.minigame').addClass('hidden');
    $('.splash').removeClass('hidden');
    $('.groups').addClass('hidden');
    document.querySelectorAll('.group').forEach(el => { el.remove(); });
}

function start(){
    wrong = 0;
    right = 0;

    shuffle(positions);
    good_positions = positions.slice(0, 14);

    let div = document.createElement('div');
    div.classList.add('group');
    const groups = document.querySelector('.groups');

    for(let i=0; i < 36; i++){
        let group = div.cloneNode();
        group.dataset.position = i.toString();
        groups.appendChild(group);
    }

    addListeners();

    timer_start = sleep(2000, function(){
        $('.splash').addClass('hidden');
        $('.groups').removeClass('hidden');

        let blocks = document.querySelectorAll('.group');
        good_positions.forEach( pos => {
            blocks[pos].classList.add('good');
        });

        timer_game = sleep(4000, function(){
            document.querySelectorAll('.group.good').forEach(el => {$(el).removeClass('good')});
            game_started = true;

            timer_finish = sleep(16000, function(){
                game_started = false;
                wrong = 3;
                check();
            });
        });
    });
}

function OpenMiniGame() {
    $('.minigame').removeClass('hidden');
    $('.splash').removeClass('hidden');
    $('.groups').addClass('hidden');
    start()
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const action = data.action
    switch (action) {
        case "startMinigame":
            return OpenMiniGame();
        case "closeMinigame":
            return CloseMenu();
        default:
        return;
    }
})