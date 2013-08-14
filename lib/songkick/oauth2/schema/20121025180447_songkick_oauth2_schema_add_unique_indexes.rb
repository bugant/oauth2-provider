class SongkickOauth2SchemaAddUniqueIndexes < ActiveRecord::Migration
  FIELDS = [:code]
  
  def self.up
    FIELDS.each do |field|
      remove_index :oauth2_authorizations, [:client_id, field]
      add_index :oauth2_authorizations, [:client_id, field], :unique => true
    end

    remove_index :oauth2_authorizations, :name => 'idx_auth_client_refresh_hash'
    add_index :oauth2_authorizations, [:client_id, :refresh_token_hash], :name => 'idx_auth_client_refresh_hash', :unique => true

    remove_index :oauth2_authorizations, [:access_token_hash]
    add_index :oauth2_authorizations, [:access_token_hash], :unique => true
    
    remove_index :oauth2_clients, [:client_id]
    add_index :oauth2_clients, [:client_id], :unique => true
    
    add_index :oauth2_clients, [:name], :unique => true
  end
  
  def self.down
    FIELDS.each do |field|
      remove_index :oauth2_authorizations, [:client_id, field]
      add_index :oauth2_authorizations, [:client_id, field]
    end
    remove_index :oauth2_authorizations, [:access_token_hash]
    add_index :oauth2_authorizations, [:access_token_hash]
    
    remove_index :oauth2_clients, [:client_id]
    add_index :oauth2_clients, [:client_id]
    
    remove_clients :oauth2_clients, [:name]
  end
end

