local keywords = {
  "on", "off", "not",
  "public", "private", "interface",
  "shared", "static",
  "source", "target", "build", "type",
  "required",
  "version", "languages",
  "build_shared_libs", "build_interface", "install_interface",
  "cmake_cxx_standard", "cmake_c_standard",
  "cmake_cxx_standard_required", "cmake_c_standard_required",
  "cmake_c_compiler", "cmake_c_compiler_id", "cmake_c_compiler_version",
  "cmake_cxx_compiler", "cmake_cxx_compiler_id", "cmake_cxx_compiler_version",
  "cmake_system_name",
  "project_name",
  "glob",
  "win32",
  "git_repository", "git_tag",
  "configure_command", "install_command", "build_command",
}

for _, k in ipairs(keywords) do
  vim.cmd(string.format("iab <buffer> %s %s", k, k:upper()))
end
