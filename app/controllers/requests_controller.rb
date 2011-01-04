class RequestsController < ApplicationController
  load_and_authorize_resource 

  # GET /requests
  # GET /requests.xml
  def index
    @requests = Request.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests }
    end
  end

  # GET /requests/1
  # GET /requests/1.xml
  def show
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @request }
    end
  end

  # GET /requests/new
  # GET /requests/new.xml
  def new
    @book = Book.find(params[:id])
    @request = Request.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @request }
    end
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])
    @book = Book.find(@request.book)
  end

  # POST /requests
  # POST /requests.xml
  def create
    @request = Request.new(params[:request])

    @borrower = current_user
    UserMailer.request_book_confirmation(@request.book, @borrower).deliver

    respond_to do |format|
      if @request.save
        format.html { redirect_to(@request.book, :notice => 'Request was successfully created.') }
        format.xml  { render :xml => @request, :status => :created, :location => @request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.xml
  def update
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to(@request, :notice => 'Request was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.xml
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to(requests_url) }
      format.xml  { head :ok }
    end
  end

  def approve
    @request = Request.find(params[:id])
    book = @request.book
    book.borrower_user_id = @request.user.id
    book.save

    @request.destroy

    redirect_to requests_path, :notice => 'Book has been approved'
  end
end
