
  Dir.chdir("../rotas/") { |directory| Dir.mkdir("test_rota_name")}

  Dir.chdir("../rotas/test_rota_name")

  File.new("testfile.txt", "w+")
