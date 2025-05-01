require "./assembler.rb"
require "fileutils"

puts "[ Inicio de Compilación ]"

# Lista de archivos de prueba organizados por carpeta
rutas_de_archivos = {
  "add": ["Add"],
  "max": ["Max", "MaxL"],
  "rect": ["Rect", "RectL"],
  "pong": ["Pong", "PongL"]
}

# Función para comparar el contenido real de dos archivos .hack
def archivos_iguales?(archivo1, archivo2)
  a = File.readlines(archivo1).map(&:strip).reject(&:empty?)
  b = File.readlines(archivo2).map(&:strip).reject(&:empty?)
  a == b
end

# Recorre todos los archivos y los ensambla
rutas_de_archivos.each_key do |clave|
  rutas_de_archivos[clave].each do |nombre_archivo|
    ruta = "../#{clave.to_s}/#{nombre_archivo}"
    Assembler.new(ruta).compile
    exito = archivos_iguales?("#{ruta}.hack", "#{ruta}.cmp.hack")
    puts (exito ? "[ Éxito ]" : "[ Error ]") + " Ensamblado y Comparado #{nombre_archivo}.hack"
  end
end

puts "[ Fin de Compilación ]"