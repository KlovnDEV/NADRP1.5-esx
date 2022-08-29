$(function(){
    const Colours = {
      '~r~' : 'red',
      '~o~' : 'orange',
      '~b~' : '#6495ed',
      '~c~' : 'grey',
      '~g~' : '#7CFC00',
      '~p~' : 'purple',
      '~y~' : 'yellow',
      '~qalle~' : '#252830'
    }

    window.addEventListener("message", function(event){   
        if(event.data.options){
          var options = event.data.options;

          for (color in Colours) { 
            if (options.text.includes(color)) {
              objArray = {}
              objArray[color] = '<span style="color:' + Colours[color] + ';">'
              objArray["~s~"] = '</span>'

              var newText = options.text.allReplace(objArray)

              options.text = newText
            }
          }

          new Noty(options).show();
        }else{
          var maxNotifications = event.data.maxNotifications;
          Noty.setMaxVisible(maxNotifications.max, maxNotifications.queue);
        };
    });

    String.prototype.allReplace = function(obj) {
      var returnString = this;

      for (var id in obj) {
        returnString = returnString.replace(new RegExp(id, 'g'), obj[id]);
      }

      return returnString;
    };
});