-- get the current directory in Finder
on run {input, parameters}
	tell application "Finder"
		set _cwd to quoted form of (POSIX path of (folder of the front window as alias))
	end tell
	CD_to(_cwd)
end run

-- change directory in iTerm (version >= 3)
on CD_to(_cwd)
	tell application "iTerm"
		activate
		
		try
			set _window to first window
		on error
			set _window to (create window with profile "Default")
		end try
		
		tell _window
			create tab with default profile
			tell current session
				write text "cd " & _cwd & ";clear;"
			end tell
		end tell
	end tell
end CD_to