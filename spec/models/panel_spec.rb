require 'rails_helper'

RSpec.describe Panel, type: :model do
  it { is_expected.to belong_to :comic }

  it { is_expected.to respond_to :comic_id }
  it { is_expected.to respond_to :caption }
  it { is_expected.to respond_to :image_file_name }
  it { is_expected.to respond_to :image_content_type }
  it { is_expected.to respond_to :image_file_size }
  it { is_expected.to respond_to :image_updated_at }


end
