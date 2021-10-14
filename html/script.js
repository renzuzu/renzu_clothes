        var jobdata = {}
        var myjob = undefined
        let weapondata = {}
        let wardrobe = {}
        let ownedvehicles = {}
        let craftables = {}
        let imglink = ''
        let online = {}
        let generatedPin = 1234;
        let submittedPin = 0;
        let attempt = 3;
        let datas = {}
        let inventorytype = {}
        let exporting = false
        let blacklist = {}
        let showall = false
        function formatsecond(s) {
          var timestamp = s;
          var hours = Math.floor(timestamp / 60 / 60);
          var minutes = Math.floor(timestamp / 60) - (hours * 60);
          var seconds = timestamp % 60;
          var formatted = hours.toString().padStart(2, '0') + ':' + minutes.toString().padStart(2, '0') + ':' + seconds.toString().padStart(2, '0');
          return formatted
        }

        let invcache = {}
        let inventoryroom = false
        function CreateClothes(clothes,inventory) {
          $("#clothemain").html('')
          document.getElementById("clothemain").style.overflowY = 'scroll';
          document.getElementById("clothemain").scrollTop = 0;
          var icon = {}
          icon['T-Shirt 1'] = 'fas fa-tshirt'
          icon['T-Shirt 2'] = 'fad fa-tshirt'
          icon['Torso 1'] = 'fas fa-user-tie'
          icon['Torso 2'] = 'fad fa-user-tie'
          icon['Decals 1'] = 'fas fa-badge-sheriff'
          icon['Decals 2'] = 'fad fa-badge-sheriff'
          icon['Arms'] = 'fas fa-hand-spock'
          icon['Pants 1'] = `<svg onclick="CreateSubClothes('pants_1')" class="leaderboard__picture" style="    border-radius: 5%;
          background: #080808;
          width: 60px;     font-size: 50px;
          color: #fff;" viewBox="-120 0 448 448"
          xmlns="http://www.w3.org/2000/svg">
          <path fill="#ffffff" stroke="grey" d="m0 448h72.59375l23.40625-304.617188c.324219-4.164062 3.796875-7.378906 7.976562-7.378906 4.175782 0 7.652344 3.214844 7.976563 7.378906l23.453125 304.617188h72.59375v-368.640625c-24.527344-3.566406-43.792969-22.832031-47.359375-47.359375h-16.640625v40c0 13.253906-10.746094 24-24 24h-16c-4.417969 0-8-3.582031-8-8v-56h-48.640625c-3.566406 24.527344-22.832031 43.792969-47.359375 47.359375zm0 0"/>
          <path d="m0 0h96v16h-96zm0 0"/>
          <path d="m0 63.199219c15.699219-3.234375 27.964844-15.5 31.199219-31.199219h-31.199219zm0 0"/>
          <path d="m144 0h64v16h-64zm0 0"/>
          <path d="m208 32h-31.199219c3.234375 15.699219 15.5 27.964844 31.199219 31.199219zm0 0"/>
          <path d="m112 0h16v16h-16zm0 0"/>
          <path d="m128 72v-40h-16v48h8c4.417969 0 8-3.582031 8-8zm0 0"/>
        </svg>`
          icon['Pants 2'] = `<svg onclick="CreateSubClothes('pants_2')" class="leaderboard__picture" style="    border-radius: 5%;
          background: #080808;
          width: 60px;     font-size: 50px;
          color: #fff;" viewBox="-120 0 448 448"
          xmlns="http://www.w3.org/2000/svg">
          <path fill="#ffffff" stroke="grey" d="m0 448h72.59375l23.40625-304.617188c.324219-4.164062 3.796875-7.378906 7.976562-7.378906 4.175782 0 7.652344 3.214844 7.976563 7.378906l23.453125 304.617188h72.59375v-368.640625c-24.527344-3.566406-43.792969-22.832031-47.359375-47.359375h-16.640625v40c0 13.253906-10.746094 24-24 24h-16c-4.417969 0-8-3.582031-8-8v-56h-48.640625c-3.566406 24.527344-22.832031 43.792969-47.359375 47.359375zm0 0"/>
          <path d="m0 0h96v16h-96zm0 0"/>
          <path d="m0 63.199219c15.699219-3.234375 27.964844-15.5 31.199219-31.199219h-31.199219zm0 0"/>
          <path d="m144 0h64v16h-64zm0 0"/>
          <path d="m208 32h-31.199219c3.234375 15.699219 15.5 27.964844 31.199219 31.199219zm0 0"/>
          <path d="m112 0h16v16h-16zm0 0"/>
          <path d="m128 72v-40h-16v48h8c4.417969 0 8-3.582031 8-8zm0 0"/>
        </svg>`
          icon['Shoes 1'] = 'fas fa-boot'
          icon['Shoes 2'] = 'fad fa-boot'
          icon['Chain 1'] = 'fas fa-scarf'
          icon['Chain 2'] = 'fad fa-scarf'
          icon['Helmet 1'] = 'fas fa-hard-hat'
          icon['Helmet 2'] = 'fad fa-hard-hat'
          icon['Glasses 1'] = 'fas fa-glasses'
          icon['Glasses 2'] = 'fad fa-glasses'
          icon['Bag'] = 'fas fa-backpack'
          icon['Bag color'] = 'fad fa-backpack'
          icon['Watches 1'] = 'fas fa-watch'
          icon['Watches 2'] = 'fad fa-watch'
          icon['Ear accessories'] = 'far fa-gem'
          icon['Ear accessories color'] = 'fad fa-gem'
          icon['Bracelets 1'] = 'fas fa-hand-point-left'
          icon['Bracelets 2'] = 'fad fa-hand-point-left'
          icon['Mask 1'] = 'fas fa-mask'
          icon['Mask 2'] = 'fad fa-mask'
          icon['Bulletproof vest 1'] = 'fas fa-shield'
          icon['Bulletproof vest 2'] = 'fad fa-shield'
          if (!inventory) {
            //$("#save_clothe").html('Save Clothe')
            inventoryroom = false
            for (const i in clothes) {
              var owned = 'green'
              if (!clothes[i].owned) {
                owned = 'red'
              }
              var kick = `<i style="color:white; font-size:40px;right: 1.1vw;
              position: absolute;
              top: 1.5vw;" id="modify_weapon" onclick="nav(this,'`+clothes[i].name+`_id',true)" class="fad fa-chevron-square-right"></i>`
              //
              var ico = `<i onclick="CreateSubClothes('`+clothes[i].name+`')" style="    border-radius: 5%;
              background: #080808;
              width: 60px;     font-size: 50px;
              color: #fff;" class="`+icon[clothes[i].label]+` leaderboard__picture"></i>`
              if (clothes[i].label == 'Pants 1' || clothes[i].label == 'Pants 2') {
                ico = icon[clothes[i].label]
              }
              $("#clothemain").append(`<article style="    padding-left: 13px;
              width: 92% !important;" class="leaderboard__profile" id="`+clothes[i].name.replace(":", "")+`">
              <i class="fas fa-eye" style="    position: absolute;
              top: 14%;
              left: 2.5%;
              color: #f5fdff;"></i>
              `+ico+`

              <span class="leaderboard__name" style="margin-top:20px;
              height: 50px;">`+clothes[i].label+`</span>
              <input onmouseup="mouseUp()" class="slider__input" id="`+clothes[i].name+`_id" type="range" value="`+clothes[i].value+`" max="`+clothes[i].max+`" style="position: absolute;
              top: 50%;
              left: 19%;
              width: 40%;">
                <div id="h4-container"><div id="h4-subcontainer"><h4>0<span></span></h4></div></div>

              <span id="deposit_item" onclick="nav(this,'`+clothes[i].name+`_id')" class="leaderboard__value" style="
              position: absolute;
              right: 8vw;
              top: 1.5vw;
              "><i class="fad fa-chevron-square-left" style="font-size:40px;color:white;"></i><span></span>
              
              </span>
              <div style="
              position: absolute;
              top: 1.2vw;
              right: 4.1vw;
              background: #222;
              width: 3.5vw;
              height: 40px;
              border-style: double;
              padding: 0;
              margin: 0;
              border-radius: 5px;
              "><input type="text" class="indextext" id="`+clothes[i].name+`_id_" name="`+clothes[i].name+`_id_" style="    text-align: center;    width: 80%;" value="0"></div>
                        <span class="leaderboard__value">`+kick+`<span></span></span>
              </article>`);
              document.getElementById(""+clothes[i].name+"_id_").value = clothes[i].value
            }
            const sliderInput = document.querySelectorAll('.slider__input');
            for (var i = 0; sliderInput.length > i; i++) {
              sliderInput[i].addEventListener('input', function () {
                const valueContainer = this.parentNode.parentNode.querySelector('.slider__value');
                for (var i = 0; blacklist > i; i++) {
                  if (this.value == blacklist[i]) {
                    this.value = this.value + 1
                  }
                }
                const sliderValue = this.value;
                const maxVal = this.getAttribute('max');
                document.getElementById(""+this.id+"_").value = sliderValue
                $.post("https://renzu_clothes/changeclothes",JSON.stringify({name:this.id,value:sliderValue,slider:true}),function(cb) {
                  if (cb) {}
                });
              });
            }

            const indextext = document.querySelectorAll('.indextext');
            for (var i = 0; indextext.length > i; i++) {
              indextext[i].addEventListener('input', function () {
                const valueContainer = this.parentNode.parentNode.querySelector('.slider__value');
                for (var i = 0; blacklist > i; i++) {
                  if (this.value == blacklist[i]) {
                    this.value = this.value + 1
                  }
                }
                const sliderValue = this.value;
                const maxVal = this.getAttribute('max');
                var field = this.id.replace("_id_", "_id");
                document.getElementById(field).value = sliderValue
                document.getElementById(field+'_').value = sliderValue
                $.post("https://renzu_clothes/changeclothes",JSON.stringify({name:field,value:sliderValue}),function(cb) {
                  if (cb) {}
                });
              });
            }
          } else {
            $("#save_clothe").html('<i class="fas fa-save"></i> Save Current')
            inventoryroom = true
            var inv = {}
            var icon = {}
            icon['tshirt'] = 'fas fa-tshirt'
            icon['torso'] = 'fas fa-user-tie'
            icon['decals'] = 'fas fa-badge-sheriff'
            icon['arms'] = 'fas fa-hand-spock'
            icon['pants'] = `<svg onclick="CreateInvCat('pants')" class="leaderboard__picture" style=" border-radius: 5%;
            background: #0c0c0cb5;
            width: 5.0vw;
            font-size: 50px;
            color: #fff;
            height: 7vh;
            margin-bottom: 20px;
            margin-left: 7px;" viewBox="-120 0 448 448"
            xmlns="http://www.w3.org/2000/svg">
            <path fill="#ffffff" stroke="grey" d="m0 448h72.59375l23.40625-304.617188c.324219-4.164062 3.796875-7.378906 7.976562-7.378906 4.175782 0 7.652344 3.214844 7.976563 7.378906l23.453125 304.617188h72.59375v-368.640625c-24.527344-3.566406-43.792969-22.832031-47.359375-47.359375h-16.640625v40c0 13.253906-10.746094 24-24 24h-16c-4.417969 0-8-3.582031-8-8v-56h-48.640625c-3.566406 24.527344-22.832031 43.792969-47.359375 47.359375zm0 0"/>
            <path d="m0 0h96v16h-96zm0 0"/>
            <path d="m0 63.199219c15.699219-3.234375 27.964844-15.5 31.199219-31.199219h-31.199219zm0 0"/>
            <path d="m144 0h64v16h-64zm0 0"/>
            <path d="m208 32h-31.199219c3.234375 15.699219 15.5 27.964844 31.199219 31.199219zm0 0"/>
            <path d="m112 0h16v16h-16zm0 0"/>
            <path d="m128 72v-40h-16v48h8c4.417969 0 8-3.582031 8-8zm0 0"/>
            </svg>`
            icon['shoes'] = 'fas fa-boot'
            icon['chain'] = 'fas fa-scarf'
            icon['helmet'] = 'fas fa-hard-hat'
            icon['glasses'] = 'fas fa-glasses'
            icon['bags'] = 'fas fa-backpack'
            icon['watches'] = 'fas fa-watch'
            icon['ears'] = 'far fa-gem'
            icon['bracelets'] = 'fas fa-hand-point-left'
            icon['mask'] = 'fas fa-mask'
            icon['bproof'] = 'fas fa-shield'
            for (const i in inventory) {
              if (!inv[inventory[i].compo]) {
                inv[inventory[i].compo] = {}
              }
              if (!inv[inventory[i].compo][inventory[i].draw]) {
                inv[inventory[i].compo][inventory[i].draw] = {}
              }
              inv[inventory[i].compo][inventory[i].draw][inventory[i].texture] = inventory[i].texture
            }
            $("#clothemain").append(`<main id="clothegrid" style="display: grid;
            height: calc(49vh + 10px);
            grid-template-columns: repeat(4,6.0vw);
            grid-auto-rows: 11.0vh;
            grid-gap: 5px;
            gap: 11px;
            overflow-x: hidden;
            overflow-y: scroll;"></main>`)
            for (const i in inv) {
              //for (const draw in inv[i]) {
                //for (const texture in inv[i][draw]) {
                  var ico = `<i onclick="CreateInvCat('`+i+`')" style="border-radius: 5%;
                  background: #0c0c0cb5;
                  width: 5.0vw;
                  font-size: 50px;
                  color: #fff;
                  height: 7vh;
                  margin-bottom: 20px;
                  margin-left: 7px;
                  " class="`+icon[i]+` leaderboard__picture"></i>`
                  if (i == 'pants') {
                    ico = icon[i]
                  }
                  $("#clothegrid").append(`<article style="    padding: 5px;
                  width: 5.75vw !important;
                  height: 10vh;" class="leaderboard__profile" id="`+i+`" style="padding: 5px;width: 19% !important;">
                  `+ico+`
                  <span style="
                  position: absolute;
                  bottom: 0;
                  background: #23292d96;
                  width: 83%;
                  color: #fdfdfd;
                  padding: 5px;
                  text-align: center;
                  font-size: 10px;
                  text-shadow: 1px 2px #000000;
                  margin: 5px;
                  border-bottom-right-radius: 5px;
                  border-bottom-left-radius: 5px;
                  height: 12px;
                  overflow: hidden;
                  ">`+i+`</span>
                  </article>`);
                //}
              //}
            }
            invcache = inv
          }
        }

        function CreateInvCat(compo) {
          $('#clothemain').html('');
          document.getElementById("clothemain").style.overflowY = 'hidden';
          document.getElementById("clothemain").scrollTop = 0;
          for (const i in invcache[compo]) {
              if (i) {
                for (const texture in invcache[compo][i]) {
                  var data = datas[compo][i][texture]
                  var hash = data !== undefined && data.NameHash || ''
                  var name = data !== undefined && data.label || hash
                  $("#clothemain").append(`<article style="    padding: 5px;
                  width: 5.7vw !important;
                  height: 10vh;" onclick="changeclotheinv('`+compo+`',`+i+`,`+texture+`)" class="leaderboard__profile" id="`+i+`" style="padding: 5px;width: 19% !important;">
                  <span style="
                  position: absolute;
                  bottom: 0;
                  background: #23292d96;
                  width: 83%;
                  color: #fdfdfd;
                  padding: 5px;
                  text-align: center;
                  font-size: 10px;
                  text-shadow: 1px 2px #000000;
                  margin: 5px;
                  border-bottom-right-radius: 5px;
                  border-bottom-left-radius: 5px;
                  height: 12px;
                  overflow: hidden;
                  ">`+name+`</span>
                  <img style="border-radius: 5%;
                  background: #080808;
                  width: 5.7vw;
                  font-size: 50px;
                  color: #fff;
                  height: 10vh;" src="https://raw.githubusercontent.com/renzuzu/carmap/main/carmap/clothes/`+hash+`.png"/>
                  </article>`);
                }
              }
            }
        }

        function isblacklisted(index) {
          for (const i in blacklist) {
            if(index == blacklist[i]) {
              return true
            }
          }
          return false
        }
        function CreateSubClothes(index) {
          $('#clothemain').html('');
          document.getElementById("clothemain").style.overflowY = 'hidden';
          document.getElementById("clothemain").scrollTop = 0;
          index = index.replace("_1", "");
          index = index.replace("_2", "");
          for (const i in datas[index]) {
            if (!isblacklisted(i)) {
              var hash = datas[index][i]['0'] !== undefined && datas[index][i]['0'].NameHash || ''
              var name = datas[index][i]['0'] !== undefined && datas[index][i]['0'].label || hash
              $("#clothemain").append(`<main id="clothegrid" style="display: grid;
              height: calc(49vh + 10px);
              grid-template-columns: repeat(4,6.0vw);
              grid-auto-rows: 11.0vh;
              grid-gap: 5px;
              gap: 11px;
              overflow-x: hidden;
              overflow-y: scroll;"></main>`)
              $("#clothegrid").append(`<article style="    padding: 5px;
              width: 5.7vw !important;
              height: 10vh;" onclick="CreateClothingline('`+i+`','`+index+`')" class="leaderboard__profile" id="`+i+`" style="padding: 5px;width: 19% !important;">
              <span style="
              position: absolute;
              bottom: 0;
              background: #23292d96;
              width: 83%;
              color: #fdfdfd;
              padding: 5px;
              text-align: center;
              font-size: 10px;
              text-shadow: 1px 2px #000000;
              margin: 5px;
              border-bottom-right-radius: 5px;
              border-bottom-left-radius: 5px;
              height: 12px;
              overflow: hidden;
              ">`+name+`</span>
                      <img style="border-radius: 5%;
                      background: #080808;
                      width: 5.7vw;
                      font-size: 50px;
                      color: #fff;
                      height: 10vh;" src="https://raw.githubusercontent.com/renzuzu/carmap/main/carmap/clothes/`+hash+`.png"/>
                      </article>`);
              //document.getElementById(""+clothes[i].name+"_id_").value = clothes[i].value
            }
          }
        }
        var tempclothedata = {}
        function CreateClothingline(cat,index) {
          $('#clothemain').html('');
          tempclothedata = {
            componentid : index, 
            drawableid : cat
          }
          document.getElementById("clothemain").style.overflowY = 'scroll';
          document.getElementById("clothemain").scrollTop = 0;
          for (const i in datas[index][cat]) {
            var hash = datas[index][cat][i] !== undefined && datas[index][cat][i].NameHash || ''
            var name = datas[index][cat][i] !== undefined && datas[index][cat][i].label || hash
            var price = datas[index][cat][i] !== undefined && datas[index][cat][i].Price
            var kick = `<i style="color:white; font-size:30px;" id="buy" onclick="OpenModalFunction(this,'`+i+`','`+name+`')" class="fad fa-shopping-cart"></i>`
            $("#clothemain").prepend(`<article class="leaderboard__profile" id="`+hash+`">
            <img style="    border-radius: 5%;
            background: #0808085e;
            width: 60px;height: 60px;
            padding-top: 5px;" src="https://raw.githubusercontent.com/renzuzu/carmap/main/carmap/clothes/`+hash+`.png" onerror="this.src='';this.onerror='defaultimg()'" alt="`+hash+`" class="leaderboard__picture">
            <span class="leaderboard__name" style="margin-top:20px;
            height: 50px;">`+name+` - <span style="color:#85e685;">$ `+price+` </span></span>
            <span class="leaderboard__value">`+kick+`<span>
            <span class="leaderboard__value" style="
            position: absolute;
            right: 17%;
            top: 32%;
            "><i onclick="preview('`+i+`')" class="fas fa-mouse" style="color: white; font-size: 30px;"></i>
            <span>
            </span></span>
            </article>`);
          }
        }

        function preview(index) {
          var name = tempclothedata['componentid']+'_2'
          for (var i = 0; blacklist > i; i++) {
            if (tempclothedata['drawableid'] == blacklist[i]) {
              tempclothedata['drawableid'] = tempclothedata['drawableid'] + 1
            }
          }
          $.post("https://renzu_clothes/changeclothes",JSON.stringify({name:name,value:index,slider:false,drawableid:tempclothedata['drawableid']}),function(cb) {
            if (cb) {}
          });
        }

        function changeclotheinv(compo,draw,text) {
          for (var i = 0; blacklist > i; i++) {
            if (draw == blacklist[i]) {
              draw = draw + 1
            }
          }
          $.post("https://renzu_clothes/changeclothes",JSON.stringify({name:compo,value:text,slider:false,drawableid:draw,texture:text}),function(cb) {
            if (cb) {}
          });
        }

        function mouseUp() {
          $.post("https://renzu_clothes/mouseup",JSON.stringify({}),function(cb) {
                if (cb) {}
          });
        }

        function OpenModalFunction(e,id,label,type) {
          if (e.id == 'viewcart') {
            $.post("https://renzu_clothes/viewcart",JSON.stringify({}),function(incart) {
              if (incart) {
                var cart = `
                <div id="`+e.id+`" class="modal" style="display: block;">
                  <div class="modal-content" style="width:40%;">
                    <div class="modal-header">
                      <span class="close" onclick="this.parentNode.parentNode.parentNode.remove()">×</span>
                      <h2 style="text-align:center;">InCart <span id="playername"></span></h2>
                    </div>
                    <div class="modal-body" style="    margin: 10px;
                      text-align: center;">
                     
                      <div class="list-wrapper" style="    max-height: 500px;">
                        <ul class="list" id="incart">
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>`
                $('#modalfunc').append(cart)
                  for (const i in incart) {
                    if (incart[i].incart) {
                      var kick = `<i style="color:white; font-size:30px;" class="fad fa-check"></i>`
                      var string = `
                      <li id="`+incart[i].namehash+`" class="list-item" style="border-color: #757575;">
                      <i onclick="removeitem('`+incart[i].skin+`','`+incart[i].compo+`','`+incart[i].namehash+`')" class="fas fa-times-square" style="    position: relative;
                      margin-top: 5%;
                      color: #ff6e6e;"></i>
                      <div class="list-item__image" style="margin-left: 20px;">
                      <img style="
                      border-radius: 5%;
                      background: #080808;
                      width: 30px;
                      height:30px;
                      " src="https://raw.githubusercontent.com/renzuzu/carmap/main/carmap/clothes/`+incart[i].namehash+`.png" onerror="this.src='https://raw.githubusercontent.com/renzuzu/carmap/main/carmap/clothes/`+incart[i].namehash+`.png';this.onerror='defaultimg()'" class="leaderboard__picture" alt="Thumbnail">
                      </div>
                      <div class="list-item__content">
                      <h4 style="    color: white;
                      font-size: 14px;
                      margin-top: 12px;
                      font-weight: 100;
                      width: 50%;
                      float:left;
                      }">  `+incart[i].label+`  <span style="color:grey;font-weight:500;">x1</span> </h4>
                      <h4 style="
                      color: #a1ff95;
                      font-size: 14px;
                      margin-top: 12px;
                      font-weight: 100;
                      width: 20%;
                      float: right;
                      ">  $`+incart[i].price+`  </h4>
                      <p> </p>
                      </div>
                      </li>`
                      $('#incart').append(string)
                  }
                  }
              }
              $.post("https://renzu_clothes/get_total",JSON.stringify({}),function(t) {
                $('#totalcost').html(t)
              });
            });
          }
          if (e.id == 'buy') {
            var give = `<div id="`+e.id+`" class="modal" style="display: block;">
            <div class="modal-content" style="width:40%;">
              <div class="modal-header">
                <span class="close" onclick="CloseModal()">×</span>
                <h2 style="text-align:center;">Buy Item `+label+`<span id="playername"></span></h2>
              </div>
              <div class="modal-body">
                <form id="manage" method="post" style="margin: 10px;">
                <label for="url" style="display: inline;
                background: #212427;
                margin-right: 5px;
                height: 40px;
                padding-top: 11px;
                padding-bottom: 10px;
                font-size: 15px;">Amount:</label>
                  <input type="text" id="amount" name="amount">
                  <button style="    position: absolute;
                  /* float: right; */
                  top: 35%;
                  left: unset;
                  right: 7%;
                  width: 80px;
                  height: 40px;" id="buyitem" onclick="event.preventDefault();buy('`+id+`')">Confirm</button>
                  <p style="
    text-align: center;
    color: #909090;
    margin-top: 0;
    font-size: 12px;
">Bought clothes will be available to your clothing inventory (Wardrobe)</p>
                </form>
              </div>
            </div>
            </div>`
            $('#modalfunc').append(give)
          }

          if (e.id == 'load_clothe') {
            var give = `<div id="`+e.id+`" class="modal" style="display: block;">
            <div class="modal-content" style="width:50%;">
              <div class="modal-header">
                <span class="close" onclick="CloseModal()">×</span>
                <h2 style="text-align:center;">Select Clothing form Wardrobe <span id="playername"></span></h2>
              </div>
              <div class="modal-body" style="    margin: 0vw;
              text-align: center;">
                <form name="clothing" id="clothing" style="width: 95%;
                background: #1e1e1f21;height: 350px;
                overflow: scroll;">

                </form>
              </div>
            </div>
            </div>`
            $('#modalfunc').append(give)
            let installed = {}
            $('#clothing').html('')
            var str = `<div class="option" style="width:100%;background:#0a0a0ac7;
            margin-top: 5px;
            color: #bbe6ff;
            font-family: 'Font Awesome 5 Free';border-radius:5px">
            <input type="radio" name="wardrobeload" id="noclothe" value="noclothe">
            <label for="noclothe" aria-label="noclothe" style="width:90%;">
            <span style="border: none;
            background: none;border-radius: 5px;
            border: 2px solid #2f2f2f;
            background: #121517;
            border-color: #8d8f92;
            height: 50px;
            width: 50px;"><i id="noclothe_check" class="fas fa-tshirt" style="font-size:30px; color:white;padding:8px;"></i></span>

            <span style="
            /* border: none; */
            background: none;
            border-radius: 5px;
            border: 2px solid #2f2f2f;
            background: #121517;
            border-color: #8d8f92;
            height: 30px;
            width: 30px;
            /* float: right; */
            position: absolute;
            right: 20px;
            "><i style="font-size: 20px;color: #9c9c9c;padding: 5px;z-index: 999;" class="fas fa-window-close"></i></span>
            No Clothes
            </label>
            </div>`
            $('#clothing').append(str)
            for (const i in wardrobe) {
              console.log("wardrobe")
              if (wardrobe[i]) {
                var cloth = `<div class="option" style="width:100%;background:#0a0a0ac7;
                margin-top: 5px;
                color: #bbe6ff;
                font-family: 'Font Awesome 5 Free';border-radius:5px">
                <input type="radio" name="wardrobeload" id="`+i+`" value="`+i+`">
                <label for="`+i+`" aria-label="`+i+`" style="width:90%;">
                <span style="border: none;
                background: none;border-radius: 5px;
                border: 2px solid #2f2f2f;
                background: #121517;
                border-color: #8d8f92;
                height: 50px;
                width: 50px;"><i id="`+i+`_check" class="fas fa-tshirt" style="font-size:30px; color:white;padding:8px;"></i></span>

                <span style="
                /* border: none; */
                background: none;
                border-radius: 5px;
                border: 2px solid #2f2f2f;
                background: #121517;
                border-color: #8d8f92;
                height: 30px;
                width: 30px;
                /* float: right; */
                position: absolute;
                right: 20px;
                "><i style="font-size: 20px;color: #9c9c9c;padding: 5px;z-index: 999;" class="fas fa-window-close"></i></span>
                `+i+`
                </label>
                </div>`
                $('#clothing').prepend(cloth)
              }
            }
            var rad = document.clothing.wardrobeload;
            console.log(rad,'gago')
            var prev = null;
            for(var i = 0; i <= rad.length; i++) {
              rad[i].onclick = function () {
                //(prev)? 
                if(this !== prev) {
                    prev = this;
                }
                console.log('gago')
                $.post("https://renzu_clothes/selectclothes",JSON.stringify({name:this.value}),function(cb) {
                  if (cb) {
                    
                  }
                });
              };
            }
          }
          
          if (e.id == 'save_clothe') {
            var str = `<div id="`+e.id+`" class="modal" style="display: block;">
            <div class="modal-content" style="width:35%;">
              <div class="modal-header">
                <span class="close" onclick="CloseModal()">×</span>
                <h2 style="text-align:center;">Save Current Outfit <span id="playername"></span></h2>
              </div>
              <div class="modal-body">
                <form id="manage" method="post" style="margin-bottom: 90px;    padding: 23px;">
                <input type="hidden" id="save_to" name="save_to" value="Create New">
                  <div class="select" id="clotheselect">
                    <select class="control control--select" id="saveto" onchange="SaveF()">
                      <option selected="selected" value="new">➕ Create New</option>
                    </select>
                  </div>
                <label id="clothelabel" for="url" style="display: inline;
                background: #0b0c0c69;
                margin-right: 5px;
                height: 40px;
                padding-top: 11px;
                padding-bottom: 10px;">Name:</label>
                  <input type="text" id="savenew" name="savenew" style="
                  float: right;
                  position: absolute;
                  top: 52%;">
                  <button style="height: 40px;
                  position: absolute;
                  top: 82%;
                  left: 3%;" id="saveclothes" onclick="event.preventDefault();Saveclothes('`+id+`')">Confirm</button>
                </form>
              </div>
            </div>
            </div>`
            var str2 = `<div id="`+e.id+`" class="modal" style="display: block;">
            <div class="modal-content" style="width:35%;">
              <div class="modal-header">
                <span class="close" onclick="CloseModal(true)">×</span>
                <button style="
                position: absolute;
                top: 2%;
                left: 1%;
                height: 30px;
                width: 100px;
                font-size: 12px;
        " id="viewcart" onclick="OpenModalFunction(this)"><i class="fas fa-shopping-cart"></i> View Cart</button>
                <h2 style="text-align:center;">Purchase Clothing <span id="playername"></span></h2>
              </div>
              <div class="modal-body">
              <h1 style="
    margin-bottom: 10px;
    color: #a4e0b7;
"><i style="color:white;" class="fad fa-money-check-edit-alt"></i> Total Cost: <span id="totalcost">1000000</span></h1>
                <form id="manage" method="post" style="margin-bottom: 90px;    padding: 23px;">
                <input type="hidden" id="save_to" name="save_to" value="Create New">
                <input type="hidden" id="paymethod" name="paymethod" value="cash">
                  <div class="select" id="clotheselect">
                    <select class="control control--select" id="saveto" onchange="SaveF()">
                      <option selected="selected" value="new">➕ Create New</option>
                    </select>
                  </div>
                <label id="clothelabel" for="url" style="display: inline;
                background: #0b0c0c69;
                margin-right: 5px;
                height: 40px;
                padding-top: 11px;
                padding-bottom: 10px;">Name:</label>
                  <input type="text" id="savenew" name="savenew" style="
                  float: right;
                  position: absolute;
                  top: 52%;">
                  <button style="height: 40px;
                  position: absolute;
                  top: 82%;
                  left: 3%;" id="saveclothes" onclick="event.preventDefault();Saveclothes('`+id+`')">Confirm</button>
                  <div class="select" id="clotheselect" style="
    width: 50%;
    float: right;
    position: absolute;
    bottom: -20px;
    left: 40%;
">
                    <select class="control control--select" id="paymentmethod" onchange="PaymentMethod()">
                      <option selected="selected" value="cash">💸 Cash</option>
                    <option value="bank">💳 Bank</option>
                    </select>
                  </div>
                </form>
              </div>
            </div>
            </div>`
            if (!inventoryroom) {
              inventoryroom = exporting
            }
            if (inventoryroom) {
              $('#modalfunc').append(str)
            } else {
              $('#modalfunc').append(str2)
            }
            for (const i in wardrobe) {
              
              $('#saveto').append('<option value="'+i+'">'+i+'</option>')
              //<option value="sample">SAMPLE</option>
            }
            $.post("https://renzu_clothes/get_total",JSON.stringify({}),function(t) {
              $('#totalcost').html(t)
            });
          }
        }

        function removeitem(item,compo,id) {
          $.post("https://renzu_clothes/removeitem",JSON.stringify({name:item,compo:compo}),function(cb) {
            if (cb) {
              document.getElementById(id).remove()
            }
          });
        }

        function defaultimg(e) {
          document.getElementById(e.id).src = 'https://www.teamaxe.com/img/cms/livraison-teamaxe1.png'
        }
        function moneytype() {
          document.getElementById("money_type").value = document.getElementById("moneyselect").value
        }

        function SaveF() {
          var val = document.getElementById("saveto").value
          if (val !== 'new') {
            document.getElementById("clothelabel").style.display = 'none'
            document.getElementById("savenew").style.display = 'none'
            document.getElementById("savenew").disabled = true
          } else {
            document.getElementById("clothelabel").style.display = 'inline'
            document.getElementById("savenew").style.display = 'inline'
            document.getElementById("savenew").disabled = false
          }
          document.getElementById("save_to").value = val
        }

        function PaymentMethod() {
          var val = document.getElementById("paymentmethod").value
          document.getElementById("paymethod").value = val
        }

        function addtocart() {
          $.post("https://renzu_clothes/addtocart",JSON.stringify({}),function(cb) {
            if (cb) {
              //$('#modalfunc').html('')
            }
          });
        }

        function buyvehicle(model) {
          
          $.post("https://renzu_clothes/buyvehicle",JSON.stringify({model:model}),function(cb) {
              if (cb) {
                window.location.reload(false)
                //document.getElementById(weapon).style.color = '';
              }
          });
        }

        function Saveclothes(type,id) {
          var newclothe = undefined
          var overwriteold = undefined
          var add = undefined
          var payment = undefined
          for (const i in $( "form" ).serializeArray()) {
            var u = $( "form" ).serializeArray()
            if ($( "form" ).serializeArray()[i].name == 'savenew') {
              newclothe = $( "form" ).serializeArray()[i].value
            }
            if ($( "form" ).serializeArray()[i].name == 'add') {
              add = $( "form" ).serializeArray()[i].value
            }
            if ($( "form" ).serializeArray()[i].name == 'save_to') {
              overwriteold = $( "form" ).serializeArray()[i].value
            }
            if ($( "form" ).serializeArray()[i].name == 'paymethod') {
              payment = $( "form" ).serializeArray()[i].value
            }
            
          }
          $.post("https://renzu_clothes/saveclothes",JSON.stringify({newclothe:newclothe,overwriteold:overwriteold,add:add,payment:payment}),function(cb) {
            if (cb) {
              $.post("https://renzu_clothes/close",{},function(datab){
                window.location.reload(false); 
              });
              $('#modalfunc').html('')
            }
          });
        }

        function CloseModal(cursor) {
          $('#modalfunc').html('')
          if (cursor && !showall) {
            $.post("https://renzu_clothes/close",{},function(datab){
              window.location.reload(false); 
            });
          }
        }

        function buy(id) {
          
          //document.getElementById("main").innerHTML = '';
          var amount = 0
          for (const i in $( "form" ).serializeArray()) {
            var u = $( "form" ).serializeArray()
            if ($( "form" ).serializeArray()[i].name == 'amount') {
              amount = $( "form" ).serializeArray()[i].value
            }
          }
          $.post("https://renzu_clothes/buyitem",JSON.stringify({componentid:tempclothedata['componentid'],drawableid:tempclothedata['drawableid'],textureid:id}),function(data){
            if (data) {
              $('#modalfunc').html('')
            }
          })
        }

        function refresh(id) {
          document.getElementById("clothemain").innerHTML = '';
          $.post("https://renzu_clothes/refresh",{},function(data){});
        }

        function capitalizeFirstLetter(string) {
          return string.charAt(0).toUpperCase() + string.slice(1);
        }

        function nav(e,id,next) {
          var val = document.getElementById(id).value
          
          if (next) {
            val = +val + 1
          } else {
            val = val - 1
          }
          for (var i = 0; blacklist > i; i++) {
            if (val == blacklist[i]) {
              val = val + 1
            }
          }
          document.getElementById(id).value = val
          document.getElementById(""+id+"_").value = val
          $.post("https://renzu_clothes/changeclothes",JSON.stringify({name:id,value:val}),function(cb) {
            if (cb) {}
          });
        }

        window.addEventListener('message', function (table) {
          let event = table.data;
          if (event.type == 'Cashier') {
            wardrobe = event.content.wardrobe
            OpenModalFunction({id :'save_clothe'})
          }
          if (event.type == 'Clothes') {
            const clothe = event.content.clothe
            event.type = undefined
            $("#logo").attr("src", event.content.logo);
            datas = event.content.datas
            CreateClothes(clothe,event.content.inventory,event.content.export)
            wardrobe = event.content.wardrobe
            imglink = event.content.img || ''
            exporting = event.content.export || false
            blacklist = event.content.blacklist || {}
            showall = event.content.blacklist || false
            if (event.content.nowardrobe && !event.content.inventory) {
              $('#save_clothe').css('position','top','left','height','width','font-size').css('absolute','30%','65%','50px','150px','15px');
              $('#load_clothe').css('position','top','left','width').css('absolute','50%','33%','115px');
              document.getElementById("load_clothe").style.display = "none";
              document.getElementById("remove_clothe").style.display = "none";
              document.getElementById("viewcart").style.display = "block";
              document.getElementById("addtocar").style.display = "block";
              document.getElementById("save_clothe").style.display = "none";
            } else {
              $('#save_clothe').css({
                'position' : 'absolute',
                'top' : '20%',
                'left' : 'unset',
                'right' : '10%',
                'width' : '120px',
                'height' : 'unset'
              });
              $('#load_clothe').css({
                'position' : 'absolute',
                'top' : '20%',
                'left' : 'unset',
                'right' : '10%',
                'width' : '120px',
                'height' : 'unset'
              });
              document.getElementById("save_clothe").style.display = "block";
              document.getElementById("viewcart").style.display = "none";
              document.getElementById("addtocar").style.display = "none";
              //$('#save_clothe').css('position','top','left','height','width','font-size').css('absolute','30%','65%','50px','150px','15px');
              $('#load_clothe').css('position','top','left','width','right').css('absolute','20%','unset','120px','10%');
              document.getElementById("load_clothe").style.display = "block";
              document.getElementById("remove_clothe").style.display = "block";
            }
            if (event.content.export) {
              document.getElementById("viewcart").style.display = "none";
              document.getElementById("addtocar").style.display = "none";
              document.getElementById("save_clothe").style.display = "block";
              document.getElementById("save_clothe").style.fontSize = "11px";
            }
            if (event.content.shopname) {
              document.getElementById("shopname").innerHTML = event.content.shopname;
            }
            inventorytype = event.content.type
            document.getElementById("clothemenu").style.display = "block";
          }

          if (event.type == 'updateclothe') {
            const clothe = event.clothe.name
            const clothemax = event.clothe.max
            event.type = undefined
            
            $('#'+clothe+'').attr('max', Number(clothemax));
            //$('#'+clothe+'').attr('value', 0);
            document.getElementById(clothe+'_id').setAttribute('max', Number(clothemax));
            document.getElementById(clothe+'_id').value = 0
            document.getElementById(clothe+'_id_').value = 0
          }

          if (event.type == 'close') {
            window.location.reload(false); 
          }
        });
        document.onkeyup = function (data) {
          if (data.keyCode == '27') { // Escape key 76 = L (Change the 76 to whatever keycodes you want to hide the carlock ui LINK https://css-tricks.com/snippets/javascript/javascript-keycodes/)
            $.post("https://renzu_clothes/close",{},function(datab){});
            document.getElementById("clothemenu").style.display = "none";
            window.location.reload(false); 
          }
          if (data.keyCode == '121') { // Escape key 76 = L (Change the 76 to whatever keycodes you want to hide the carlock ui LINK https://css-tricks.com/snippets/javascript/javascript-keycodes/)
            $.post("https://renzu_clothes/close",{},function(datab){});
            window.location.reload(false); 
          }
        }
        function imageExists(image_url){

          var http = new XMLHttpRequest();
      
          http.open('HEAD', image_url, false);
          http.send();
      
          return http.status != 404;
      
        }
        function removeclothe() {
          $.post("https://renzu_clothes/removeclothe",{},function(datab){});
        }
      var modal = document.getElementById("myModal");
      
      var span = document.getElementsByClassName("close")[0];
      
      window.onclick = function(event) {
        if (event.target == modal) {
          modal.style.display = "none";
        }
      }