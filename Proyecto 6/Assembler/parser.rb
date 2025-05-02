=begin
Esta clase descompone cada instrucción (escrita en el lenguaje Hack) en sus campos internos.
Ejemplo:
D=D+1;JEQ -> D D+1 JEQ
M=M+D -> M M+D
=end

module Parser
  def _destination
    # Devuelve el destino de la instrucción, que está antes del '=' en una C_INSTRUCTION
    case type
    when C_INSTRUCTION
      return nil if equal_index == 0  # Si no hay '=', no hay destino
      @str[0...equal_index]  # Extrae el destino antes del '='
    when A_INSTRUCTION, VARIABLE_INSTRUCTION
      @str[1..-1]  # Para A_INSTRUCTION y VARIABLE_INSTRUCTION, el destino está después del '@'
    when LABEL_INSTRUCTION
      @str[1..-2]  # Para las etiquetas, el destino es el nombre de la etiqueta sin los paréntesis
    end
  end

  def _computation
    # Devuelve la parte de cómputo de la instrucción (lo que está entre '=' y ';', o después de '=')
    if type == C_INSTRUCTION
      equal_index > 0 ? @str[equal_index+1..end_of_computation_index-1] : @str[0..end_of_computation_index-1]
    end
  end

  def _jump
    # Devuelve la parte de salto después de ';' en una C_INSTRUCTION, si existe
    (type == C_INSTRUCTION && end_of_computation_index > 0) ? @str[end_of_computation_index+1..-1] : nil
  end

private
  def equal_index
    # Encuentra la posición del '=' en la cadena, o devuelve 0 si no existe
    @str.index("=") || 0
  end

  def end_of_computation_index
    # Encuentra la posición del ';' en la cadena, o devuelve 0 si no existe
    @str.index(";") || 0
  end
end
