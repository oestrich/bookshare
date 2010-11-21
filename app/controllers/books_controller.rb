class BooksController < ApplicationController
  include BooksHelper

  load_and_authorize_resource

  # GET /books
  # GET /books.xml
  def index
    #@books = Book.all
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    #@book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    #@book = Book.new

    if current_user.locations.count == 0
      redirect_to new_location_path, :notice => "Need to add a location first"
    else

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @book }
      end
    end
  end

  # GET /books/1/edit
  def edit
    #@book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    # use the configure method to setup your api credentials
    configure :secret => 'G6aSVuRonDppc5l1U10dRZW360LL+b3khm/9G6q9', :key => '0HFCVPEF9DTHP5DXV482'

    #@book = Book.new(params[:book])
    
    item = lookup @book.isbn
    
    if item.raw == nil
      #convert UPC to isbn
      @book.isbn = convert @book.isbn

      item = lookup @book.isbn
    end


    if item.raw != nil

      images = lookup(@book.isbn, {:ResponseGroup => "Images"})

      @book.title = item.title
      @book.asin = item.raw.ASIN
      @book.details_url = item.raw.DetailPageURL
      @book.image_url = images.raw.ImageSets.ImageSet.MediumImage.URL

      if item.raw.ItemAttributes.Author.class == Array
        @book.author = item.raw.ItemAttributes.Author.join ", "
      else
        @book.author = item.raw.ItemAttributes.Author
      end

      respond_to do |format|
        if @book.save
          format.html { redirect_to(new_book_path, :notice => "Successfully added #{@book.title}.") }
          format.xml  { render :xml => @book, :status => :created, :location => @book }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:alert] = "Invalid barcode"
      redirect_to "/books/new"
    end
  end


  # PUT /books/1
  # PUT /books/1.xml
  def update
    #@book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    #@book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url, :notice => 'Book has been removed') }
      format.xml  { head :ok }
    end
  end

  def borrow
    @book = Book.find(params[:id])

    @book.borrower_user_id = current_user.id
    @book.save

    @borrower = current_user
    UserMailer.borrow_book_confirmation(@book, @borrower).deliver
    
    redirect_to(@book, :notice => 'Book has been borrowed and its owner has been notified.')
  end

  def return
    #@book = Book.find(params[:id])

    @book.borrower_user_id = nil
    @book.save
    UserMailer.return_book_confirmation(@book, current_user).deliver
 
    redirect_to(@book, :notice => 'Book has been returned and owner has been notified')
  end
end
