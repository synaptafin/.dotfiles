function fzf_select_history
  if test (count $argv) = 0
    history | fzf | read foo
  else
    history | fzf --query "$argv" | read foo
  end

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

