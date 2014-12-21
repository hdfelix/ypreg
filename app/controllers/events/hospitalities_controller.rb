class Events::HospitalitiesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @lodgings = @event.unassigned_lodgings_as_hospitality
    @hospitalities = @event.hospitalities
  end

  def new
    @event = Event.find(params[:event_id])
    @hospitalities = @event.hospitalities
    @new_hospitality_ids = []
    @lodgings = @event.unassigned_lodgings_as_hospitality
  end

  def show
    @event = Event.find(params[:event_id])
    @lodgings = @event.unassigned_lodgings_as_hospitality
  end 

  def create
    @event = Event.find(params[:event_id])
    @new_hospitality_ids = params[:new_hospitality_ids]

    @event.hospitalities << @new.hospitality_ids.collect do |id|
      Hospitality.create(event: @event, lodging: Lodging.find(id))
    end

    if @event.save
      if @new_hospitality_ids.count == 1
        flash[:notice] = "1 hospitality created successfully."
      else
        flash[:notice] = "#{@new_hospitality_ids.count} hospitalities created successfully."
        redirect_to event_path
      end
    else
      if @new_hospitality_ids.count == 1
        flash[:error] = 'Error assigning the hospitality to the event.'
      else
        flash[:error] = 'Error assigning the hospitalities to the event.'
        render action: 'new'
      end
    end
  end

  def remove
    @event = Event.find(params[:event_id])
    hospitalities = Hospitality.joins(:lodging)
      .where(lodging_id: params[:hospitality_lodging_ids])

    hospitalities.each do |h|
      h.destroy
    end
    redirect_to @event
  end

  def add
    @event = Event.find(params[:event_id])
    Lodging.find(params[:lodging_ids]).each do |l|
      @event.hospitalities << Hospitality.create(lodging: l)
    end
    @event.save
    redirect_to @event
  end

  # def add_multiple
  #   @event = Event.find(params[:event_id])
  #   @lodgings = @event.unassigned_lodgings_as_hospitality   
  # end

  # def remove_multiple
  # end

  # Old code
  # def assign
  #   # @hospitalities = Hospitality.new
  #   # Lodgings that could be assigned as available for the given event
  #   @lodging = lodgings_for_assign
  # end

  # def assigns
  #   # calling lodging here hospitality; getting an error if I use @lodging 
  #   # on the assings.js render
  #   lodging = Lodging.find(params[:lodging_id])
  #   @event = Event.find(params[:event_id])
  #   @event.hospitalities << @hospitality = Hospitality.create(event_id: @event.id, lodging_id: lodging.id)

  #   respond_to do |format|
  #     format.html { redirect_to @event }
  #     format.js
  #   end
  # end

  def destroy
    @event = Event.find(params[:event_id])
    @hospitality = @event.hospitalities.find(params[:id])
    @event.hospitalities.delete(@hospitality)

    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end

  private

  def lodgings_for_assign
    ev = Event.find(params[:event_id])
    if ev.hospitalities.empty?
      Lodging.all
    else
      Lodging.where.not(id: ev.hospitalities.pluck(:lodging_id))
    end
  end
end
