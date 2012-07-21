module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => "<center>"+I18n.localize(@shown_month, :format => "%B %Y <center>"),
      :previous_month_text => "<center> << " + month_link(@shown_month.prev_month)+"</center>",
      :next_month_text => "<center>"+month_link(@shown_month.next_month) + " >> </center>"    }
  end

  def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      %(<a href="/event/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
    end
  end
end
