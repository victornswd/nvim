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
-- More ASCII ideas here: https://github.com/glepnir/dashboard-nvim/wiki/Ascii-Header-Text

local starter = require('mini.starter')
local function telescope()
  return {
    { action = 'lua project_files()', name = 'Files', section = 'File Management' },
    { action = 'Telescope live_grep', name = 'Live grep', section = 'File Management' },
    { action = 'Telescope oldfiles', name = 'Old files', section = 'File Management' },
    {
      action = "lua pcall(require('harpoon.ui').toggle_quick_menu)",
      name = 'List Harpoon',
      section = 'List Harpoon',
    },
    { action = 'VimwikiIndex', name = 'Wiki Index', section = 'VimWiki' },
    { action = 'Telescope themes', name = 'Themes', section = 'Neovim Internals' },
    { action = 'Telescope command_history', name = 'Command history', section = 'Neovim Internals' },
  }
end
starter.setup({
  header = donut,
  items = {
    telescope(),
    starter.sections.sessions(5, true),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning('center', 'center'),
  },
})
