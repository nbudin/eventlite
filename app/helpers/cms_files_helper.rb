module CmsFilesHelper
  def icon_for_content_type(content_type)
    case content_type
    when %r(\Aaudio/) then 'file-audio-o'
    when %r(\Avideo/) then 'file-video-o'
    when 'application/pdf' then 'file-pdf-o'
    when 'application/zip', 'application/x-bzip', 'application/x-bzip2', 'application/x-tar', 'application/x-7z-compressed'
      'file-zip-o'
    when 'application/msword' then 'file-word-o'
    when 'application/vnd.ms-excel' then 'file-excel-o'
    when 'application/vnd.ms-powerpoint' then 'file-powerpoint-o'
    when 'text/plain', 'application/rtf' then 'file-text-o'
    else 'file-o'
    end
  end
end
