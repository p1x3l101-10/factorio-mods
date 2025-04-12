if script.active_mods["lignumis"] then
  require("compatibility.lignumis.control")
end

if script.active_mods["diverse-external-rocket-parts"] and script.active_mods["maraxsis"] then
  require("compatibility.multi.scripts.fix-maraxis")
end