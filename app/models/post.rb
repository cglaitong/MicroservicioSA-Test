class Post < ApplicationRecord
  has_many_attached :uploads

 # has_one_attached :dp


  def uploads_on_disk(i)

    ActiveStorage::Blob.service.send(:path_for, uploads[i].key)


  end


  def set_filename
    if self.uploads.attached?
      self.uploads[0].blob.update(filename: "123prueba")
    end
  end





end
