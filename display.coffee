#
# ──────────────────────────────────────────────── I ───────
#   :::::: S U P E R N E R D
# ──────────────────────────────────────────────────────────
#

options =
  theme    : "pro"        # snazzy | pro

#
# ─── ALL COMMANDS ───────────────────────────────────────────────────────────
#

commands =
  battery: "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto " +
           "| cut -f1 -d';'"
  time   : "date +\"%H:%M\""
  wifi   : "/System/Library/PrivateFrameworks/Apple80211.framework/" +
           "Versions/Current/Resources/airport -I | " +
           "sed -e \"s/^ *SSID: //p\" -e d"
  volume : "osascript -e 'output volume of (get volume settings)'"
  cpu : "ps -A -o %cpu | awk '{s+=$1} END {printf(\"%.2f\",s/8);}'"
  mem : "ps -A -o %mem | awk '{s+=$1} END {print s \"%\"}' "
  hdd : "df -hl | awk '{s+=$5} END {print s \"%\"}'"
  date  : "date +\"%a %d %b\""
  focus : "/usr/local/bin/chunkc tiling::query --window name"
  ismuted : "osascript -e 'output muted of (get volume settings)'"
  ischarging : "sh ./supernerd.widget/scripts/ischarging.sh"
  activedesk : "echo $(/usr/local/bin/chunkc tiling::query -d id)"
  isitunesplaying: "osascript -e 'tell application \"iTunes\" to if player state is playing then return true'"
  isspotifyrunning : "osascript -e 'if application \"Spotify\" is running then return true'"
  itunes : "osascript -e 'tell application \"iTunes\" to if player state is playing then artist of current track & \" - \" & name of current track'"
  spotify : "osascript -e 'if application \"Spotify\" is running then tell application \"Spotify\" to artist of current track & \" - \" & name of current track '"
#
# ─── COLORS ─────────────────────────────────────────────────────────────────
#

colors =
  if options.theme == 'snazzy'
    black:   "#282a36"
    red:     "#ff5c57"
    green:   "#5af78e"
    yellow:  "#f3f99d"
    blue:    "#57c7ff"
    magenta: "#ff6ac1"
    cyan:    "#9aedfe"
    white:   "#eff0eb"
  else if options.theme == 'pro'
    black:   "#101010"
    red:     "#D17D60"
    green:   "#9ABA77"
    yellow:  "#BAB777"
    blue:    "#77ADBA"
    magenta: "#BA77B2"
    cyan:    "#77BAAD"
    white:   "#8f8f8f"
  else if options.theme == 'exper'
    black:   "#0f1023"
    red:     "#BC6E56"
    green:   "#9ABA77"
    yellow:  "#BAB777"
    blue:    "#9bc1bc"
    magenta: "#DB5168"
    cyan:    "#C5EFCB"
    white:   "#e6ebe0"
#
# ─── COMMAND ────────────────────────────────────────────────────────────────
#

command: "echo " +
         "$(#{ commands.battery }):::" +
         "$(#{ commands.time }):::" +
         "$(#{ commands.wifi }):::" +
         "$(#{ commands.volume }):::" +
         "$(#{ commands.cpu }):::" +
         "$(#{ commands.mem }):::" +
         "$(#{ commands.hdd }):::" +
         "$(#{ commands.date }):::" +
         "$(#{ commands.focus }):::" +
         "$(#{ commands.ismuted }):::" +
         "$(#{ commands.ischarging }):::" +
         "$(#{ commands.activedesk }):::" +
         "$(#{ commands.isitunesplaying}):::" +
         "$(#{ commands.isspotifyrunning}):::" +
         "$(#{ commands.itunes}):::" +
         "$(#{ commands.spotify}):::"


#
# ─── REFRESH ────────────────────────────────────────────────────────────────
#

refreshFrequency: 256

#
# ─── RENDER ─────────────────────────────────────────────────────────────────
#

render: ( ) ->
  """
  <div id="main">
    <div class="bar" id="top">

      <div class="container" id="left">
        <div class="widg" id="music">
          <i class="fab fa-itunes-note"></i>
          <span class="playing"></span>
        </div>
      </div>

    <div class="container" id="center">
      <div class="widg" id="window">

        <span class="window-output"></span>
      </div>
    </div>

    <div class="container" id="right">
      <div class="widg" id="volume">
        <span class="volume-icon"></span>
        <span class="volume-output"></span>
      </div>
      <div class="widg" id="wifi">
        <i class="fa fa-wifi"></i>
        <span class="wifi-output"></span>
      </div>
      <div class="widg" id="battery">
        <span class="battery-icon"></span>
        <span class="battery-output"></span>
      </div>
      <div class="widg" id="time">
        <i class="far fa-clock"></i>
        <span class="time-output"></span>
      </div>
      <div class="widg" id="date">
        <i class="far fa-calendar-alt"></i>
        <span class="date-output"></span>
      </div>
    </div>
  </div>

  <div class="bar" id="bottom">

    <div class="container" id="left">
      <div class="widg" id="home">
        <i class="fas fa-home"></i>
        ~/
      </div>
      <div class="widg" id="browser">
        <i class="far fa-compass"></i>
        web
      </div>
      <div class="widg" id="mail">
        <i class="far fa-envelope"></i>
        mail
      </div>
      <div class="widg" id="messages">
        <i class="far fa-comments"></i>
        msg
      </div>
      <div class="widg" id="terminal">
        <i class="far fa-terminal"></i>
        zsh
      </div>
      <div class="widg" id="editor">
        <i class="far fa-code"></i>
        vscode
      </div>
    </div>

    <div class="container" id="center">
    <div class="widg">
      <i class="fa fa-window-maximize desk" id="desk1"></i>
      <i class="fa fa-window-maximize desk" id="desk2"></i>
      <i class="fa fa-window-maximize desk" id="desk3"></i>
      <i class="fa fa-window-maximize desk" id="desk4"></i>
    </div>
    </div>

    <div class="container" id="right">
      <div class="widg" id="cpu">
        <i class="fa fa-spinner"></i>
        <span class="cpu-output"></span>
      </div>
      <div class="widg" id="mem">
        <i class="fas fa-server"></i>
        <span class="mem-output"></span>
      </div>

      <div class="widg" id="hdd">
        <i class="fas fa-hdd"></i>
          <span class="hdd-output"></span>
      </div>
    </div>

  </div>
</div>
  """

#
# ─── RENDER ─────────────────────────────────────────────────────────────────
#

update: ( output, domEl ) ->
  output = output.split( /:::/g )

  battery = output[ 0 ]
  time   = output[ 1 ]
  wifi = output[ 2 ]
  volume = output[ 3 ]
  cpu = output[ 4 ]
  mem = output[ 5 ]
  hdd = output[ 6 ]
  date = output[ 7 ]
  focus = output[ 8 ]
  ismuted = output[ 9 ]
  ischarging = output[ 10 ]
  activedesk = output[ 11 ]
  isitunesplaying = output[ 12 ]
  isspotifyrunning = output[ 13 ]
  itunes = output[ 14 ]
  spotify = output[ 15 ]

  # Focus
  focus = focus.split( / /g )[ 0 ]
  # Music

  div = $(domEl)

  if isspotifyrunning && not isitunesplaying
    $( ".playing" )    .text( "#{ spotify }" )
  else if isitunesplaying && not isspotifyrunning
    $( ".playing" )    .text( "#{ itunes }" )
  else if isitunesplaying && isspotifyrunning
    $( ".playing" )    .text( "iTunes and Spotify Playing. Close One music player" )
  
  $( ".time-output" )    .text( "#{ time }" )
  $( ".date-output" )    .text( "#{ date }" )
  $( ".battery-output") .text("#{ battery }")
  $( ".wifi-output") .text("#{ wifi }")
  $( ".cpu-output") .text("#{ cpu }")
  $( ".mem-output") .text("#{ mem }")
  $( ".hdd-output") .text("#{ hdd }")
  $( ".window-output" ).text( "#{ focus }" )

  $(domEl).find(".active").removeClass("active")
  $(domEl).find("#desk"+activedesk).addClass('active')

  @handleBattery( domEl, Number( battery.replace( /%/g, "" ) ), ischarging )
  @handleVolume( Number( volume ), ismuted )
  @handleSysmon( domEl, Number( cpu ), '#cpu' )
  @handleSysmon( domEl, Number( mem.replace( /%/g, "") ), '#mem' )
  @handleSysmon( domEl, Number( hdd.replace( /%/g, "") ), '#hdd' )

#
# ─── HANDLE BATTERY ─────────────────────────────────────────────────────────
#

handleBattery: ( domEl, percentage, ischarging ) ->
  div = $( domEl )

  batteryIcon = switch
    when percentage <=  12 then "fa-battery-empty"
    when percentage <=  25 then "fa-battery-quarter"
    when percentage <=  50 then "fa-battery-half"
    when percentage <=  75 then "fa-battery-three-quarters"
    when percentage <= 100 then "fa-battery-full"


  if percentage >= 20
    div.find('.battery').css('color', colors.green )
  else if percentage >= 10
    div.find('.battery').css('color', colors.yellow )
  else
    div.find('.battery').css('color', colors.red )

  if ischarging == "true"
    batteryIcon = "fas fa-bolt"
  $( ".battery-icon" ).html( "<i class=\"fa #{ batteryIcon }\"></i>" )

#
# ─── HANDLE VOLUME ─────────────────────────────────────────────────────────
#

handleVolume: ( volume, ismuted ) ->
  volumeIcon = switch
    when volume ==   0 then "fa-volume-off"
    when volume <=  50 then "fa-volume-down"
    when volume <= 100 then "fa-volume-up"


  if ismuted != 'true'
    $( ".volume-output") .text("#{ volume }")
  else
    $( ".volume-output") .text("Muted")
    volumeIcon = "fa-volume-off"

  $( ".volume-icon" ).html( "<i class=\"fa #{ volumeIcon }\"></i>" )

#
# ─── HANDLE CLICKS ────────────────────────────────────────────────────────
#
afterRender: (domEl) ->
    $(domEl).on 'click', '#music', => @run "open /Applications/iTunes.app"
    $(domEl).on 'click', '#home', => @run "open ~"
    $(domEl).on 'click', '#browser', => @run "open /Applications/Firefox.app"
    $(domEl).on 'click', '#mail', => @run "open /Applications/Airmail\\ 3.app"
    $(domEl).on 'click', '#messages', => @run "open /Applications/Messages.app"
    $(domEl).on 'click', '#editor', => @run "open /Applications/Visual\\ Studio\\ Code.app"

# ──────────────────────────────────────────────────────────────────────────────
#
# ─── COLOR SYSMON –─────────────────────────────────────────────────────────
#
handleSysmon: ( domEl, sysmon, monid ) ->
  div = $(domEl)

  if sysmon <= 10
    div.find(monid).css('color', colors.white )
  else if sysmon <= 20
    div.find(monid).css('color', colors.cyan )
  else if sysmon <= 40
    div.find(monid).css('color', colors.blue )
  else if sysmon <= 50
    div.find(monid).css('color', colors.green )
  else if sysmon <= 75
    div.find(monid).css('color', colors.yellow )
  else
    div.find(monid).css('color', colors.red )

#
# ─── STYLE ─────────────────────────────────────────────────────────────────
#
style: """
#music
  color: #{ colors.green }
  width:400px
  overflow:ellipsis
#home
  color: #{ colors.white }
#browser
  color: #{ colors.blue }
#mail
  color: #{ colors.cyan }
#messages
  color: #{ colors.green }
#terminal
  color: #{ colors.yellow }
#editor
  color: #{ colors.red }

if #{options.theme} == snazzy
  font-family: 'Menlo'
  font-size: 12px
  font-smoothing: antialiasing
  color: #{ colors.white }
  width:100%

  .bar
    background-color: #{ colors.black }
    border-radius:4px
    margin:4px
    padding-left:24px
    padding-right:24px

  .bar:after
    content: "";
    display: table;
    clear: both;

  #bottom
    margin-top:58.5%

  .container
    float: left;
    width: 33.33%
    display:flex

  #left
    justify-content:flex-start

  #right
    justify-content:flex-end

  #center
    display:block
    text-align:center

  .widg
    margin:8px

else if (#{options.theme} == pro || #{options.theme} == exper)
    font-family: 'Menlo'
    font-size: 12px
    font-smoothing: antialiasing
    color: #{ colors.white }
    width:100%
    height:100%

    .bar
      width:99.2%
      position:absolute
      box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.8);
      background: rgba(#{ colors.black }, 0.6)
      padding-left:8px
      padding-right:8px

    .bar:after
      content: "";
      display: table;
      clear: both;

    #bottom
      bottom:0px

    .container
      float: left;
      width: 33.33%
      display:flex

    #left
      justify-content:flex-start

    #right
      justify-content:flex-end

    #center
      display:block
      text-align:center

    .widg
      margin:4px
      margin-right:8px
      margin-left:4px

    .desk
      opacity:0.5

    .desk.active
      opacity:1
"""

# ──────────────────────────────────────────────────────────────────────────────
