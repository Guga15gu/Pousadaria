class Api::V1::InnsController < Api::V1::ApiController
  def index
    if params[:search].present?
      inn = Inn.find_by(registration_number: params[:search])
      qtd_inn_rooms = inn.inn_rooms.count

      render status:200, json: {
        name: inn.name, 
        registration_number: inn.registration_number, 
        description: inn.description,
        address: inn.address.full_address,
        qtd_inn_rooms: qtd_inn_rooms
      }
      
    else
      render status:404
    end

    
  end
end