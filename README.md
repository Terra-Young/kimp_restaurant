# kimp_restaurant
Analysed order data to identify the most and least popular menu items and types of cuisine
```python
import pandas as pd

# Load the datasets
menu_items = pd.read_csv('menu_items.csv')
order_details = pd.read_csv('order_details.csv')

# Inspect the data
print("Menu Items Head:")
print(menu_items.head())
print("\nOrder Details Head:")
print(order_details.head())

# Merge the data
# Note: order_details has 'item_id', menu_items has 'menu_item_id'
merged_df = pd.merge(order_details, menu_items, left_on='item_id', right_on='menu_item_id', how='left')

# 1. Most Ordered Items (Volume)
top_items_volume = merged_df['item_name'].value_counts().head(5)
bottom_items_volume = merged_df['item_name'].value_counts().tail(5)

# 2. Top Revenue Items (Value)
# Group by item name and sum price
item_revenue = merged_df.groupby('item_name')['price'].sum().sort_values(ascending=False).head(5)

# 3. Category Analysis
category_stats = merged_df.groupby('category').agg(
    total_orders=('order_details_id', 'count'),
    total_revenue=('price', 'sum')
).sort_values('total_revenue', ascending=False)

# 4. Highest Spend Orders
# Group by order_id and sum price
order_spend = merged_df.groupby('order_id')['price'].sum().sort_values(ascending=False).head(5)

# 5. Peak Times (if time is available and usable)
# order_time seems to be in order_details. Let's check format in head(), but assuming it's a string or datetime
# We can extract hour.
# Clean order_time if necessary (assuming HH:MM:SS)
# Convert to datetime to be safe, errors='coerce' to handle nulls
merged_df['order_time'] = pd.to_datetime(merged_df['order_time'], format='%I:%M:%S %p', errors='coerce')
# If format fails, try flexible parsing or inspect first.
# Let's try flexible first if standard format isn't clear, but let's stick to string slicing if format is consistent.
# Actually, let's just inspect the head output first to confirm time format before complex parsing.
# For now, I'll assume simple string processing might work if it's HH:MM:SS.
# Let's just output the calculated stats first.

print("\n--- Top 5 Items by Volume ---")
print(top_items_volume)
print("\n--- Bottom 5 Items by Volume ---")
print(bottom_items_volume)
print("\n--- Top 5 Items by Revenue ---")
print(item_revenue)
print("\n--- Category Stats ---")
print(category_stats)
print("\n--- Top 5 Orders by Spend ---")
print(order_spend)



```

```text
Menu Items Head:
   menu_item_id      item_name  category  price
0           101      Hamburger  American  12.95
1           102   Cheeseburger  American  13.95
2           103        Hot Dog  American   9.00
3           104  Veggie Burger  American  10.50
4           105   Mac & Cheese  American   7.00

Order Details Head:
   order_details_id  order_id order_date   order_time  item_id
0                 1         1     1/1/23  11:38:36 AM    109.0
1                 2         2     1/1/23  11:57:40 AM    108.0
2                 3         2     1/1/23  11:57:40 AM    124.0
3                 4         2     1/1/23  11:57:40 AM    117.0
4                 5         2     1/1/23  11:57:40 AM    129.0

--- Top 5 Items by Volume ---
item_name
Hamburger           622
Edamame             620
Korean Beef Bowl    588
Cheeseburger        583
French Fries        571
Name: count, dtype: int64

--- Bottom 5 Items by Volume ---
item_name
Cheese Quesadillas    233
Steak Tacos           214
Cheese Lasagna        207
Potstickers           205
Chicken Tacos         123
Name: count, dtype: int64

--- Top 5 Items by Revenue ---
item_name
Korean Beef Bowl         10554.60
Spaghetti & Meatballs     8436.50
Tofu Pad Thai             8149.00
Cheeseburger              8132.85
Hamburger                 8054.90
Name: price, dtype: float64

--- Category Stats ---
          total_orders  total_revenue
category                             
Italian           2948       49462.70
Asian             3470       46720.65
Mexican           2945       34796.80
American          2734       28237.75

--- Top 5 Orders by Spend ---
order_id
440     192.15
2075    191.05
1957    190.10
330     189.70
2675    185.10
Name: price, dtype: float64


```

Here is the revised README. It removes the technical "Data Structure" section and focuses entirely on the business problem, the analysis process, and the specific, data-backed findings from your files.

---

# Kimp Restaurant SQL Analysis

## 📌 The Problem

Kimp Restaurant has captured extensive transactional data but lacks the insights needed to optimize its menu and operations. The business faces three core challenges:

1. **Menu Performance:** It is unclear which dishes are driving revenue versus which are "dead weight" on the menu.
2. **Customer Behavior:** There is no visibility into spending habits—specifically, what constitutes a high-value order compared to a standard transaction.
3. **Operational Blind Spots:** Management needs to identify peak ordering categories to better manage inventory and prep stations (e.g., Asian vs. Italian stations).

## 🛠️ How It Was Solved

To address these challenges, I analyzed the raw data using **SQL**.

* **Data Linking:** I merged the transaction history (`order_details`) with the product catalog (`menu_items`) using `LEFT JOIN` to attach pricing and category data to every single item sold.
* **Categorization:** I aggregated data by cuisine type (Italian, Asian, Mexican, American) to see high-level trends.
* **Ranking:** I used `ORDER BY` and `GROUP BY` functions to identify bestsellers, highest-grossing items, and top-spending customers.

---

## 📊 Key Findings

### 1. The "Powerhouse" Dishes

The analysis revealed a distinct split between items that drive **volume** (foot traffic) and items that drive **revenue** (profit).

* **Volume Leader:** The **Hamburger** is the #1 most-ordered item (622 orders), acting as a reliable staple for the business.
* **Revenue Champion:** The **Korean Beef Bowl** is the single most valuable dish. It is the 3rd most ordered item but generates the highest total revenue (**~$10,500**), outperforming the Hamburger by nearly $2,500 due to its higher price point.
* **Hidden Gems:** **Spaghetti & Meatballs** is the 2nd highest revenue generator (~$8,400), proving that Italian entrees are crucial for the bottom line.

### 2. Category Performance

* **Top Volume:** **Asian** cuisine is the most popular category by sheer number of orders (3,470 items sold).
* **Top Revenue:** **Italian** cuisine generates the most money (**~$49,400**), despite having fewer orders than Asian. This suggests Italian items have a better profit margin or higher average price.

### 3. Menu "Dead Weight"

The analysis identified items that are taking up menu space but generating little interest:

* **Chicken Tacos** are the least popular item on the entire menu (only 123 orders).
* **Potstickers** and **Cheese Lasagna** also languish at the bottom, with just over 200 orders each.

### 4. High-Value Orders

I identified the top spending "VIP" orders to understand what a massive basket looks like.

* **Record Holder:** **Order #440** was the highest single transaction, totaling **$192.15**.
* **Trend:** The top 5 orders (including Order #2075 and #1957) all exceeded **$185**, significantly higher than the average, indicating a subset of customers placing large group orders or catering-style purchases.

---

## 💡 Recommendations

### 🛑 Menu Optimization

* **Cut the Chicken Tacos:** With only 123 orders (5x less than hamburgers), this item should be removed or reinvented to reduce ingredient waste.
* **Promote the "Stars":** The **Korean Beef Bowl** is the star of the menu. Feature this item prominently in marketing materials or as a "Chef's Special" to drive even more high-value sales.

### 💰 Upselling Strategy

* **Leverage Italian:** Since Italian dishes drive the most revenue, train staff to suggest **Spaghetti & Meatballs** or similar entrees to customers who are undecided.
* **Group Bundles:** Given the existence of $190+ orders, introduce "Family Bundles" or "Office Lunch Packs" priced around $150–$180 to specifically target the high-spenders identified in the analysis.

### 📦 Inventory Planning

* **Stock for Volume, Prep for Value:** The kitchen must prioritize stock for **Asian ingredients** (highest volume) to prevent stockouts, but ensure the **Italian station** is staffed with the most experienced cooks to protect the highest revenue stream.
