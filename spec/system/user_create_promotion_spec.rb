require 'rails_helper'

describe 'User create a  promotion' do
  it 'and success' do
    # Arrange
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
    
    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)
    # Act
    login_as inn_owner, scope: :inn_owner
    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Cadastrar Promoção'
    
    fill_in 'Quarto com Varanda', with: 'true'
    fill_in 'Quarto Térreo', with: 'true'
    click_on 'Avançar'
    
    fill_in 'Nome', with: 'Promoção de inverno'
    fill_in 'Data de início', with: '29/05/2025'
    fill_in 'Data de Fim', with: '29/06/2025'

    click_on 'Criar Promoção'
    
    # Expect
    within('section#promotions') do
      expect(page).to have_content 'Pousada dos Devs'
      expect(page).to have_content 'Recanto dos Rubistas'
    end
  end
end
