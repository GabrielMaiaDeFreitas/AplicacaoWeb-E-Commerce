module AutenticacaoHelper
  def usuario_logado
    return nil unless session[:usuario_id]

    Usuario.find_by(id: session[:usuario_id])
  end

  def logado?
    !usuario_logado.nil?
  end
end
