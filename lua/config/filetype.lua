-- Terraform filetype detection
vim.filetype.add({
  extension = {
    tf = "terraform",
    tfvars = "terraform-vars",
  },
})

-- Ansible filetype detection
vim.filetype.add({
  pattern = {
    -- Detect YAML files in directories containing ansible.cfg or .ansible-lint
    [".*%.ya?ml"] = {
      priority = -math.huge,
      function(path, bufnr)
        local dir = vim.fs.dirname(path)
        local root = vim.fs.find({ "ansible.cfg", ".ansible-lint" }, {
          path = dir,
          upward = true,
          stop = vim.env.HOME,
        })
        if #root > 0 then
          return "yaml.ansible"
        end
      end,
    },
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
