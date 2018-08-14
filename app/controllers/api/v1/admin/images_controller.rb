class Api::V1::Admin::ImagesController < ApiController
    before_action :set_image, only: :destroy

    def destroy
        @image.destroy
        head 204
    end

    private

    def set_image
        @image = Image.find(params[:id])
    end
end
