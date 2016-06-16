#Relacion 1:N
#Un post solo puede tener un usuario y se representa con => belongs_to
#Un usuario puede tener muchos posts y se representa con => has_many
class Post < ApplicationRecord
  belongs_to :user
end
