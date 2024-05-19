class ChangeDefaultReportCountInArticles < ActiveRecord::Migration[7.1]
  def change
    change_column_default :articles, :report_count, from: nil, to: 0
  end
end
