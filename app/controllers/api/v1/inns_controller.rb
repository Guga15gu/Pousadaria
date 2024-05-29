class Api::V1::InnsController < Api::V1::ApiController
  def index
    unless params[:search].present?
      return render status:404, json: {error: 'CNPJ não enviado na requisição'}
    end
    
    unless Inn.find_by(registration_number: params[:search])
      render status:404, json: {error: 'Não encontrado'}
    else
      inn = Inn.find_by(registration_number: params[:search])
      qtd_inn_rooms = inn.inn_rooms.count

      render status:200, json: {
        name: inn.name, 
        registration_number: inn.registration_number, 
        description: inn.description,
        address: inn.address.full_address,
        qtd_inn_rooms: qtd_inn_rooms
      }
    end  

  end
end