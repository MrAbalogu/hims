class UserDatatable < AjaxDatatablesRails::Base


  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= { 

      surname: { source: "Enrolee.surname", cond: :like, searchable: true, orderable: true },
      firstname:  { source: "Enrolee.firstname",  cond: :like },
      enrolee_number:        { source: "Enrolee.enrolee_number" },
      primary_provider:        { source: "Enrolee.primary_provider" },
      phone:        { source: "Enrolee.phone" },
      email:        { source: "Enrolee.email" },
      state:        { source: "Enrolee.state" },
      cover_status:        { source: "Enrolee.cover_status" },
      plan:        { source: "Enrolee.plan" },
      expiry_date:        { source: "Enrolee.expiry_date" },
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        surname: record.surname,
        firstname: record.firstname,
        # company: record.company.name,
        enrolee_number: record.enrolee_number,
        primary_provider: record.primary_provider,
        phone: record.phone,
        email: record.email,
        state: record.state,
        cover_status: record.cover_status,
        plan: record.plan,
        expiry_date: record.expiry_date,

        # example:
        # id: record.id,
        # name: record.name
      }
    end
  end

  private

  def get_raw_records
    # insert query here
    Enrolee.all
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
