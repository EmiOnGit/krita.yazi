local M = {}
function M:peek(job)
	require("image"):peek(job)
end

function M:seek(job)  end


function M.extract_7z(path, cache_path)
	local last_err = nil
	local try = function(name)
		local child = Command(name):args({"e","-i!preview.png", tostring(path), "-so"}):stdout(Command.PIPED):spawn()
		Command("tee"):stdin(child:take_stdout()):args({tostring(cache_path)}):output()
		if not child then
			last_err = err
		end
		return child
	end


	local child
	if ya.target_os() == "macos" then
		child = try("7zz") or try("7z")
	else
		child = try("7z") or try("7zz")
	end

	if not child then
		return ya.err("Failed to start both `7z` and `7zz`, error: " .. last_err)
	end
	return child, last_err
end
function M:preload(job)
	local cache_url = ya.file_cache(job)

	if not cache_url or fs.cha(cache_url) then
		return true
	end
	local child = M.extract_7z(job.file.url, cache_url)
	
	return true
end

return M
