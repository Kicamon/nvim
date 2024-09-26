local running_commands = {}

local commands = {
  ['c'] = {
    command = {
      'gcc "$filename" -o "$runfile"',
      './"$runfile"',
      'rm -f "$runfile"',
    },
  },
  ['cpp'] = {
    command = {
      'g++ "$filename" -std=c++20 -O2 -g -Wall -o "$runfile"',
      './"$runfile"',
      'rm -rf "$runfile"',
    },
  },
  ['c_lib'] = {
    command = 'gcc -c -fPIC -shared "$filename" -o "$runfile".so',
    modus = 'job',
  },
  ['go'] = {
    command = 'go run "$filename"',
  },
  ['python'] = {
    command = 'python3 "$filename"',
  },
  ['lua'] = {
    command = 'luajit "$filename"',
  },
  ['sh'] = {
    command = 'bash "$filename"',
  },
  ['html'] = {
    command = 'live-server --browser=' .. _G.browser,
    modus = 'job',
  },
  ['markdown'] = {
    command = 'typora "$filename"',
    modus = 'job',
  },
}

function running_commands.get_commands()
  return commands
end

function running_commands.commands_list()
  return vim.tbl_keys(commands)
end

return running_commands
