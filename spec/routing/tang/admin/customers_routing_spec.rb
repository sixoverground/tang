require 'rails_helper'

module Tang
  RSpec.describe Admin::CustomersController, type: :routing do
    routes { Tang::Engine.routes }
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/admin/customers').to route_to('tang/admin/customers#index')
      end

      it 'routes to #show' do
        expect(get: '/admin/customers/1').to route_to('tang/admin/customers#show', id: '1')
      end

      it 'routes to #edit' do
        expect(get: '/admin/customers/1/edit').to route_to('tang/admin/customers#edit', id: '1')
      end

      it 'routes to #update via PUT' do
        expect(put: '/admin/customers/1').to route_to('tang/admin/customers#update', id: '1')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/admin/customers/1').to route_to('tang/admin/customers#update', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: '/admin/customers/1').to route_to('tang/admin/customers#destroy', id: '1')
      end
    end
  end
end
