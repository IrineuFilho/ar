require 'spec_helper'

describe Ar::DataMappers::RoleMapper, type: :mapper, fast: true do
  let(:mapper) { Ar::DataMappers::RoleMapper.instance }

  describe 'mapping to record instance' do
    let(:entity)           { Ar::Entities::Role.new(name: 'some_role')}
    let(:repository_class) { Ar::Repositories::Roles::RepositoryRole }
    let(:record_instance)  { mapper.map_to_record(repository_class, entity) }

    it 'record_instance should be an instance of Ar::Repositories::Roles::RepositoryRole' do
      expect(record_instance).to be_a Ar::Repositories::Roles::RepositoryRole
    end

    it 'record_instance should fill the property :name from entity property' do
      expect(record_instance.name).to eql 'some_role'
    end
  end

  describe 'mapping to entity instance' do
    let(:entity)          { Ar::Entities::Role.new }
    let(:action_record)   { create :repository_action, :index }
    let(:record)          { create :repository_role, action_ids: [action_record.id] }
    let(:entity_instance) { mapper.map_to_entity(record, entity) }

    it 'entity_instance should fill the property :name from record property' do
      expect(entity_instance.name).to eql 'some_role'
    end

    it 'entity_instance should fill the property :id from record property' do
      expect(entity_instance.id).to be == record.id
    end

    it 'entity_instance should fill the property :actions from record property' do
      expect(entity_instance.actions).to eq [action_record]
    end

    it 'entity_instance should fill the property :action_ids from record property' do
      expect(entity_instance.action_ids).to eq [action_record.id]
    end

  end

end