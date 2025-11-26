-- Ansible filetype detection
vim.filetype.add({
  pattern = {
    -- Detect Ansible playbooks and task files
    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*%.ansible%.ya?ml"] = "yaml.ansible",
  },
  filename = {
    -- Common Ansible filenames
    ["playbook.yml"] = "yaml.ansible",
    ["playbook.yaml"] = "yaml.ansible",
    ["site.yml"] = "yaml.ansible",
    ["site.yaml"] = "yaml.ansible",
    ["main.yml"] = function(path, bufnr)
      -- Check if main.yml is in an ansible directory structure
      if path:match("/roles/") or path:match("/tasks/") or path:match("/handlers/") then
        return "yaml.ansible"
      end
      return "yaml"
    end,
  },
})
