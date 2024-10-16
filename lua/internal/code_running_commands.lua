local running_commands = {}

local commands = {
  ['c'] = {
    command = {
      'echo -e "\\e[31mCompiling...\\e[0m"',
      'gcc "$filename" -o "$runfile"',
      'echo -e "\\e[31mCompilation completed!\\e[0m"',
      './"$runfile"',
      'rm -f "$runfile"',
    },
  },
  ['cpp'] = {
    command = {
      'echo -e "\\e[31mCompiling...\\e[0m"',
      'g++ "$filename" -std=c++20 -O2 -g -Wall -o "$runfile"',
      'echo -e "\\e[31mCompilation completed!\\e[0m"',
      './"$runfile"',
      'rm -rf "$runfile"',
    },
  },
  ['make'] = {
    command = {
      'cd $workspace',
      'make test',
    },
    modus = 'center',
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
