require 'rails_helper'

describe 'User create a  promotion' do
    it 'and success' do
        owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
        Inn.create!(name: 'Pousada dos Devs', inn_owner: owner, registration_number: '30638898000199')
        Inn.create!(name: 'Recanto dos Rubistas', inn_owner: owner, registration_number: '08397842000130')
    
        visit root_path
        
        within('section#inns') do
          expect(page).to have_content 'Pousada dos Devs'
          expect(page).to have_content 'Recanto dos Rubistas'
        end
    end
end
