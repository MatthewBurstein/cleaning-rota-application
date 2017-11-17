test_rota_var = "test_rota_name"
parent_directory = "/Users/matt/Coding/Cleaning Rota App"

if !File.exist?("#{parent_directory}/rotas")
  Dir.chdir("#{parent_directory}") { |directory| Dir.mkdir("rotas")}
end

rotas_directory = "#{parent_directory}/rotas"

if !File.exist?("#{rotas_directory}/#{test_rota_var}")
  Dir.chdir("#{rotas_directory}") { |directory| Dir.mkdir("#{test_rota_var}")}
end

Dir.chdir("#{rotas_directory}/#{test_rota_var}")

File.new("testfile.txt", "w+")


#Dir.chdir("../rotas/") { |directory| Dir.mkdir("test_rota_name")}
