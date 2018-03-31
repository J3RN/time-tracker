# Restart the server if the Gemfile or models change (not automatically loaded)
guard "process", name: "server", command: "bundle exec passenger start" do
  watch("Gemfile.lock")
  watch(%r{^app/models/.+\.rb})
end
