class CommentsController < ApplicationController
    before_action :find_post


    def create 
        @comment = @post.comments.create(comment_params)
        @comment.user_id = current_user.id
        if @comment.save 
            redirect_to post_path(@post)
        else 
            puts 'error'
        end
    end

    def edit 
        @comment = @post.comments.find(params[:id])
    end

    def update 
        @comment = @post.comments.find(params[:id])
        if @comment.update(comment_params)
            redirect_to @post
        else
            render 'edit'
        end
    end

    def destroy
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to @post
    end

    private 

    def comment_params 
        params.require(:comment).permit(:text)
    end

    def find_post
        @post = Post.find(params[:post_id])
    end

end
