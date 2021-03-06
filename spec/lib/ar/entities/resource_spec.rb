require 'spec_helper'

describe Ar::Entities::Resource, type: :entity, fast: true do

  describe '#build_correct_name' do

    before { subject.build_correct_name }

    context 'when pass :full_name as "UsersController"' do
      subject { Ar::Entities::Resource.new full_name: 'UsersController' }

      it 'full_name should be "UsersController"' do
        expect(subject.full_name).to eql 'UsersController'
      end

      it 'name should be builded as "users"' do
        expect(subject.name).to eql 'users'
      end
    end

    context 'when pass :full_name as "Authentication::Someone::UsersController"' do
      subject { Ar::Entities::Resource.new full_name: 'Authentication::Someone::UsersController' }

      it 'full_name should be "Authentication::Someone::UsersController"' do
        expect(subject.full_name).to eql 'Authentication::Someone::UsersController'
      end

      it 'name should be builded as "authentication/someone/users"' do
        expect(subject.name).to eql 'authentication/someone/users'
      end
    end

  end

end
