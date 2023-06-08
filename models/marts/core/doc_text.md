{% docs fiscal_calendar %}
# Purpose
This table gives various attributes about each fiscal date in the fiscal calendar.

The goal of the fiscal calendar is to organize dates into fiscal weeks, months, quarters and years.  This allows for aggregation of financial and other results over time periods.

# Rules

There are different options on how a fiscal calendar might be organized, each of them with different trade-offs.
Wolfspeed have chosen to define our fiscal calendar as follows:

- Each fiscal year runs from July to June.
- Fiscal dates are organized into fiscal weeks.
- Fiscal weeks are organized into fiscal months.
    - In S4/HANA, fiscal months are referred to as "periods".
- Fiscal months are organized into fiscal quarters.
    - Q1, the first quarter, always comprises (fiscal) July, August and September.
    - Following from this, Q2 is Oct/Nov/Dec, Q3 is Jan/Feb/Mar and Q4 is Apr/May/Jun.
- Fiscal weeks **always** consist of 7 days, starting on a Monday and ending on a Sunday.
- Weeks are organized into fiscal months using a "4-4-5" scheme
    - The first two months of a quarter consists of 4 weeks, and the final month in the quarter has 5 weeks.

# Leap weeks

Since there are slightly more than 52 calendar weeks in a calendar year, every so often a "fiscal leap week" is needed.  This is added to realign the start of the fiscal year to the beginning of July.  This extra leap week is added to December, extending Q2 to have 14 weeks instead the usual 13.   This previously happened in fiscal years 2013 and 2019, and will next happen in fiscal year 2024.

# Ownership

The definition of the calendar is owned by the Finance team.
{% enddocs %}


{% docs col1 %}
# From md file
This column...
{% enddocs %}



{% docs col1b %}
# From md file
This column...
{% enddocs %}

