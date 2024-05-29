require 'rails_helper'

describe 'User get details of a inner' do
  context 'GET /api/v1/inners?search=30638898000199'  do
    it 'and success' do
      # Arrange
      inn_owner = InnOwner.create!(   first_name: 'Joao', last_name: 'Almeida', 
                                      document: '53783222001', email: 'joao@email.com', password: '123456')
      inn = inn_owner.create_inn!(  name: 'Pousada do Almeidinha', registration_number: '30638898000199', 
                              description: 'Um bom lugar', 
                              address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
      inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
      inn.inn_rooms.create!(name: 'Quarto sem Varanda', size: 15, guest_limit: 6)
      # Act
      get "/api/v1/inners/", params: {search: '30638898000199'}

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      
      expect(json_response["name"]).to eq 'Pousada do Almeidinha'
      expect(json_response["registration_number"]).to eq '30638898000199'
      expect(json_response["description"]).to eq 'Um bom lugar'
      expect(json_response["address"]).to eq 'Rua X, 100 - Centro - Manaus/AM'
      expect(json_response["qtd_inn_rooms"]).to eq '2'
      
      expect(json_response.keys.length).to eq 5
    end
  end
end