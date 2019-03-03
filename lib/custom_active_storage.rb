# ===================================
# Author: Maimit Patel
# Usage: create ActionDispatch::Http::UploadedFile object
#        for create attachment direct form console with ActiveStorage
# Include ActiveStorage custome methods here
# Example: images.create(title: 'test', 
#                        photo: upload_file("#{Rails.root}/public/img_1.jpeg"))
# ===================================

module CustomActiveStorage

  # return ActionDispatch::Http::UploadedFile object
  # params -> path (i.e ~/photo_sharing_app/public/img_1.jpeg)
  def upload_file(path)
    extension = File.extname(path) # return file extendion
    filename = File.basename(path, ".*") # return file name
    tempfile = Tempfile.new(['tempfile',extension]) # create tempfile
    tempfile.binmode # set binmode
    img_to_base64 = Base64.strict_encode64(File.open(path).read) # encode file to base64
    tempfile.write(Base64.strict_decode64(img_to_base64)) # decode file and write to tempfile
    tempfile.rewind()
    # get MIME type form file extendion
    mime_type = Mime::Type.lookup_by_extension(extension.gsub('.','')).to_s
    # prepare ActionDispatch::Http::UploadedFile
    img_tempfile = ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: "#{filename}.#{extension}", type: mime_type)
  end

end
