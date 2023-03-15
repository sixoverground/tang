require 'rails_helper'

module Tang
  RSpec.describe Admin::PlansController, type: :routing do
    routes { Tang::Engine.routes }

    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/admin/plans').to route_to('tang/admin/plans#index')
      end

      it 'routes to #new' do
        expect(get: '/admin/plans/new').to route_to('tang/admin/plans#new')
      end

      it 'routes to #show' do
        expect(get: '/admin/plans/1').to route_to('tang/admin/plans#show', id: '1')
      end

      it 'routes to #edit' do
        expect(get: '/admin/plans/1/edit').to route_to('tang/admin/plans#edit', id: '1')
      end

      it 'routes to #create' do
        expect(post: '/admin/plans').to route_to('tang/admin/plans#create')
      end

      it 'routes to #update via PUT' do
        expect(put: '/admin/plans/1').to route_to('tang/admin/plans#update', id: '1')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/admin/plans/1').to route_to('tang/admin/plans#update', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: '/admin/plans/1').to route_to('tang/admin/plans#destroy', id: '1')
      end
    end
  end
end
