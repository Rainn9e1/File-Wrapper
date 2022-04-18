local Wrapper = {}

--Rainn
Wrapper["getFiles"] = function(Path)
	local Return = {}
	local Tree = {}

	for _,File in pairs(listfiles(Path)) do
		table.insert(Tree, File)
	end

	return Tree
end

Wrapper["isFolder"] = function(Path)
	return isfolder(Path)
end

Wrapper["isFile"] = function(Path)
	return isfile(Path)
end

Wrapper["fileType"] = function(Path)
	if Wrapper["isFile"](Path) == true then
		local Args = string.split(Path, ".")

		return tostring(Args[#Args])
	end
end

Wrapper["delete"] = function(Path)
	if Wrapper["isFolder"]("./"..Path) then
		delfolder(Path)
	else
		delfile(Path)
	end
end

--Bug
Wrapper["fileSize"] = function(o, t)
	t = t or 0
    
	if type(o) == "string" then 
		if isfile(o) then
			return #({string.byte(readfile(o), 1, -1)}) 
		end 
	elseif o == nil then 
		o = listfiles("") 
	end
	
    	for i, v in next, o do 
		if isfile(v) then 
			t = t + #({string.byte(readfile(o), 1, -1)}) 
		elseif isfolder(v) then 
			t = t + Wrapper["fileSize"](listfiles(v), t) 
		end 
	end
	
	return t
end

Wrapper["bytes"] = function(n)
	local s = tostring(math.floor(n))
	local s = string.sub(s, 1, ((#s - 1) % 3 ) + 1) .. ({" bytes", "Kb", "Mb", "GB", "TB"})[math.floor((#s - 1) / 3) + 1]
	if n == 1 then s = s:sub(1, #s-1) end
	return s
end

return Wrapper
