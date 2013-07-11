syn region  pythonFunctionFold	start="^class " end="^\n" fold transparent

syn region  pythonFunctionFold1	start="^\z(\s*\)\%(def \|class \|STATEVECTOR \)"
  \ end="^\ze\%(\s*\n\)\+\%(\s*#.*\n\)*\%(\s*\n\)*\%(\z1\s\|\s*#\)\@!." fold transparent


