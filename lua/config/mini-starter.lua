local donut = [[
                $$$$$$$@@@@@$           
             ********##$$$$$@@$$        
          *!!======!!**##$$$$$$$$#      
         !=;;=;:;:;==!!*###$$$$$$$#     
       !===:~~--~~:;;=!!*####$$$$$##*   
      ===;:~,,...,-~:==!***#########*   
     ;!=;:~,......,-:;=!!**#########*!  
     !!=;:~,.......-~;=!!!**#######**!  
    =!!!=;;~,...   -:;=!!!****##*#***!= 
    !*###*=;:-.    ~;==!!***********!!; 
    !#$$$$$#!;.   -:;==!!!*********!!!; 
    !#$$@@@$#*:  ~;;==!!!!********!!==: 
    !*$$@@$$##*=;;===!!!!!!!!!!!!!!==;  
    ;*##$$$#*!======!!!!!!!!!!!!!!==;:  
    ;=*####**!!=====!!!!!!!!!!!!===;~   
    -;=!***!!!!!======!!!!!======;:~    
     ~:;=!!!!!===============;;;::-     
      -:;;;=======;=====;;;;;::~~,      
       .~::;;;;;;;;;;;;;;;::~~-,        
         .-~:::::::::::~:~~-,.
]]

local blackHole = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢄⡐⣄⢆⡆⣆⡢⡐⡀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢰⡰⣮⣾⠾⡟⠟⢟⠯⢿⢯⣾⣴⡡⡐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢔⡵⣯⡿⠋⠄⠁⠄⠁⠠⠐⠀⠌⠊⠻⣽⣾⡬⡂⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⡀⢄⣢⣮⣿⢿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠈⢻⡿⣿⣷⣕⣤⡠⡠⡀⡀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⡀⣠⡠⣢⣦⣵⣮⣾⣶⣷⣯⣿⣿⣿⡿⡑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⢽⣿⣿⣿⣷⣿⣿⣽⣾⣮⣾⡼⣔⣔⢤⡠⡀⠄⡀⠀⠀
⠀⠀⠀⠠⠐⡄⣇⣗⡯⣷⢿⣿⢿⣿⡿⣿⣿⣻⣿⣿⣿⣿⣿⡦⣦⣔⣤⣢⣔⣤⣢⡴⣤⣆⣦⡴⣔⣴⣼⣼⣾⣿⣿⣿⡿⣿⡿⣿⢿⡿⣿⡻⣞⠷⡝⠮⡓⢜⠠⠁
⠀⠀⠐⠀⠁⠌⡘⠜⠹⡸⢹⢺⢝⢗⢟⢯⢯⢻⠽⡝⡗⡿⢝⡿⡝⣞⢳⢫⢏⢟⢝⠟⡝⢏⢗⢛⢏⢏⢯⢻⢹⠹⡹⠸⠪⡃⠏⡣⠋⠎⡢⠣⠡⠑⠈⠌⠐⠀⠀⠀
⠀⠀⠀⠀⠐⠀⠀⠀⠁⠀⠀⠄⠀⠂⠐⠀⠐⠀⠂⠈⠐⠈⠐⠘⡪⡠⢁⢂⠐⡀⠂⠐⠈⢀⠐⡀⠢⣨⠊⠂⠁⠈⠀⠁⠁⠀⠁⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠙⢢⣂⡂⡐⡈⠄⠡⡐⣠⠢⠋⠄⠐⠈⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠉⠑⠉⠋⠃⠉⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠂⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]

local pirate = [[
.........................:^^~!!~~^:.........................
....................^HI.PG##&&&&&#BGPY7^....................
.................~JG#&&&&&&&&&&&&&&&&&&#GJ~.................
...............!P&&&&&&&&&&&&&G&&&&&&&&B&&&P!...............
.............^P&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&P^.............
............^B&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&B^............
............P&&&&&&#12&&&&&&P&&&&&&&&&&&&&&&&&&P............
...........~&&&&&&&&&&&&&&&&&&&&#&&&&&&&&&&&&&&&~...........
...........!&&PG&&&&&&&&&&&&&&&&&&&&&&GG&&&&&&&&7...........
...........!&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&!...........
...........:#&&&&&&&&#&&&#&&&&&&&&#&&&#&&&&&&&&B:...........
............J&&&&&B?~^:::^?#&&&&#?^:::^~?B&&&&&J............
.............5&&&B:....... 5&&&&Y .......:B&&&5.............
..............Y&&B:......:!B&&&&B!:......:B&&Y..............
..............!&&&B5JMOY5B&&&PP&&&BPYJ?J5B&&&!..............
..............?@&&&&&&&&&&&&Y..Y&&&&&&&&&&&&@J..............
..............~P#&&&&&&&&&&B^^~^B&&&&&&&&&&#P~..............
..........^~!^..:~!!7?G&&&&&#&&#&&&&&G?7!!~^..^!~^..........
........:Y#BASE!..... S2VlcCBsb29raW5n .....!64&&#Y:........
........^&&&&&&#!.....G@&&&&&&&&&&&&@G.....!#&&&&&&^........
.......^J&&GL&&&#7:...^?YPGBB##BBGPY?^...:?#&&&&&&&J^.......
......Y#&&&&&&&&&&#5?^.  ..::::::..  .~?5B&&&&GG&&&&#5:.....
.....:#@&&&&&&&&&&&&&#B5?~:......:~?5B&&&&&&&&&&&&&&@#:.....
......~GL1TCHY&#71;J&#74O&&BP?!!?5B&&@@&&#G5J777JPGGGY^.....
...................:~7JP#&&&&&&&&&&#PJ7~:...................
...................:~7JP#&&&&&&&&&&#PJ7^:...................
......~YPGG5J7!7J5G#&&@@&&BPJ!!JPB&&@@&&BG5J7!7J5GGGY^......
.....:#@&&&&&&&&&&&&&#B5?~:......:~?5B&&&&&&&#12&&&&@#:.....
......Y#&&&&&&&&&&#P?~:..............:~?P#GG&&&&&&&&&Y......
.......^J&&&&&&&#?:......................:?#&&&&&&&J^.......
........^&&&&&&#~..........................~#&&&&&&^........
........:Y#&&#G!............................!G&&&#Y:........
..........^~!^................................~!~^..........
]]
-- More ASCII ideas here: https://github.com/glepnir/dashboard-nvim/wiki/Ascii-Header-Text

local starter = require('mini.starter')
local function telescope()
  return {
    {
      action = "lua pcall(require('harpoon.ui').toggle_quick_menu)",
      name = "List Harpoon",
      section = "List Harpoon",
    },
    { action = "lua project_files()", name = "Files", section = "File Management" },
    { action = "Telescope live_grep", name = "Live grep", section = "File Management" },
    { action = "Telescope oldfiles", name = "Old files", section = "File Management" },
    { action = "VimwikiIndex", name = "Wiki Index", section = "VimWiki" },
    { action = "Telescope themes", name = "Themes", section = "Neovim Internals" },
    { action = "Telescope command_history", name = "Command history", section = "Neovim Internals" },
  }
end
starter.setup({
  header = blackHole,
  items = {
    telescope(),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning("center", "center"),
  },
})
