$(document).ready(function(){
    $(".container").hide();
    $(".show-records").hide();
    var current = ".create-report"; var other =  ".show-records"; var result = null
    function print(param) { 
        console.log(param)
    }
    window.addEventListener("message", function(event){
        var data = event.data
        result = data.result
        if (data.type == "open") {
            var name = data.name
            document.getElementById("doctor-name").innerHTML = "Welcome, <b>" +name+ "</b>"
            $(".container").fadeIn(500);
            
        } else if (data.type == "search") {
            Search(result)
        }
    });
    
    document.onkeyup = function (data) {
        if (data.which == 27) { //esc
            close()
            return
        }
    };

    document.onkeyup = function (data) {
        if (data.which == 13) { //enter
            Search(result)
            return
        }
    };

   $(document).on("click", "#close", function (param) { 
       close()
    })

    function close() { 
        $.post('http://nadrp-medicalrecords/close', JSON.stringify({display: false}));
        $(".container").fadeOut(500);
        current = ".create-report"; other =  ".show-records"
        setTimeout(() => {
            $(".show-records").hide();
            $(".create-report").show();
            document.getElementById("patient-data").value = ""
            document.getElementById("patient-name").value = ""
            document.getElementById("search-bar").value = ""
        }, 500);

    }
    
    $(document).on("click", ".label", function (e) { 
        var temp = current
        $(current).fadeOut(500);
        $(other).fadeIn(500);
        $(".patient-info").fadeOut(250);
        setTimeout(() => {
            $(".patient-info").css("height", "0%");
            document.getElementById("patient-data").value = ""
            document.getElementById("patient-name").value = ""
            document.getElementById("search-bar").value = ""
    
        }, 500);
        current = other
        other = temp
    });
    $(document).on("click", "#search-button", function (e) {
        var input = $("#search-bar").val()
        if (input != "") {
            $.post('http://nadrp-medicalrecords/search', JSON.stringify({input: input}));
        } else {
            warning("Search-bar must be filled!")
        }
    });

    $(document).on("click", "#patient-submit", function (e) {
        var patient_name = $("#patient-name").val()
        var patient_data = $("#patient-data").val()

        if (patient_name != "" || patient_data != "") {
            document.getElementById("patient-name").value = ""
            document.getElementById("patient-data").value = ""
            $.post('http://nadrp-medicalrecords/create', JSON.stringify({name: patient_name, text: patient_data}));
            warning("You created patient data succesfully!")
        } else {
            warning("The input areas must be filled!")
        }
        $(".patient-info").fadeIn(250);
        $(".patient-info").css("height", "60%");
    });

    $(document).on("click", ".close-info", function (e) {
        $(".patient-info").css("height", "0%");   
        setTimeout(() => {
            $(".patient-info").fadeOut(250);
            document.getElementById("search-bar").value = ""
        }, 500);
    });

    function Search(result) { 
        if (result) {
            $(".header").remove();
            $(".patient-context").remove();
            
            for (i = 0; i < result.length; i++) {
                $(".patient-info").append('<div class="header"><p class="header-text"> Patient Info </p><p id="patient-fullname"> <b>Name</b> <br>' + result[i].name + '</p><p id="patient-date"> <b>Date</b> <br> ' + result[i].date + ' </p></div><div class="patient-context"><p class="context" id="context">'+ result[i].text +'</p></div>');
                $(".patient-info").fadeIn(250);
                $(".patient-info").css("height", "60%");  
            }  
        } else {
            $(".patient-info").css("height", "0%");   
            setTimeout(() => {
                warning("No result found!")  
            }, 250);
        }
    }

    function warning(text) { 
        $("#warning").fadeIn(500);
        document.getElementById("warning").innerHTML = text
        setTimeout(() => {
            $("#warning").fadeOut(500);
        }, 3000);
    }
})

//