# Kimp Restaurant SQL Analysis
## 📌 The Problem
Kimp Restaurant has captured extensive transactional data but lacks the insights needed to optimize its menu and operations. The business faces three core challenges:
1. **Menu Performance:** It is unclear which dishes are driving revenue versus which are "dead weight" on the menu.
2. **Customer Behavior:** There is no visibility into spending habits specifically, what constitutes a high-value order compared to a standard transaction.
3. **Operational Blind Spots:** Management needs to identify peak ordering categories to better manage inventory and prep stations (e.g., Asian vs. Italian stations).

## 🛠️ How It Was Solved
To address these challenges, I analyzed the raw data using **SQL**.

**Data Linking:** I merged the transaction history (`order_details`) with the product catalog (`menu_items`) using `LEFT JOIN` to attach pricing and category data to every single item sold.

**Categorization:** I aggregated data by cuisine type (Italian, Asian, Mexican, American) to see high-level trends.

**Ranking:** I used `ORDER BY` and `GROUP BY` functions to identify bestsellers, highest-grossing items, and top-spending customers.

---
## 📊 Key Findings
### 1. The "Powerhouse" Dishes

The analysis revealed a distinct split between items that drive **volume** (foot traffic) and items that drive **revenue** (profit).

**Volume Leader:** The **Hamburger** is the #1 most-ordered item (622 orders), acting as a reliable staple for the business.

**Revenue Champion:** The **Korean Beef Bowl** is the single most valuable dish. It is the 3rd most ordered item but generates the highest total revenue (**~$10,500**), outperforming the Hamburger by nearly $2,500 due to its higher price point.

**Hidden Gems:** **Spaghetti & Meatballs** is the 2nd highest revenue generator (~$8,400), proving that Italian entrees are crucial for the bottom line.

### 2. Category Performance
**Top Volume:** **Asian** cuisine is the most popular category by sheer number of orders (3,470 items sold).

**Top Revenue:** **Italian** cuisine generates the most money (**~$49,400**), despite having fewer orders than Asian. This suggests Italian items have a better profit margin or higher average price.

### 3. Menu "Dead Weight"
The analysis identified items that are taking up menu space but generating little interest:

**Chicken Tacos** are the least popular item on the entire menu (only 123 orders).

**Potstickers** and **Cheese Lasagna** also languish at the bottom, with just over 200 orders each.

### 4. High-Value Orders
I identified the top spending "VIP" orders to understand what a massive basket looks like.

**Record Holder:** **Order #440** was the highest single transaction, totaling **$192.15**.

| order_id	| total_spend |
| --- | --- |
| 440 |	192.15 |
| 2075	| 191.05 |
| 1957 |	190.10 |
| 330	| 189.70 |
| 2675 | 185.10 |


**Trend:** The top 5 orders (including Order #2075 and #1957) all exceeded **$185**, significantly higher than the average, indicating a subset of customers placing large group orders or catering-style purchases.

---
## 💡 Recommendations
### 🛑 Menu Optimization

**Cut the Chicken Tacos:** With only 123 orders (5x less than hamburgers), this item should be removed or reinvented to reduce ingredient waste.

**Promote the "Stars":** The **Korean Beef Bowl** is the star of the menu. Feature this item prominently in marketing materials or as a "Chef's Special" to drive even more high-value sales.

### 💰 Upselling Strategy
**Leverage Italian:** Since Italian dishes drive the most revenue, train staff to suggest **Spaghetti & Meatballs** or similar entrees to customers who are undecided.

**Group Bundles:** Given the existence of $190+ orders, introduce "Family Bundles" or "Office Lunch Packs" priced around $150–$180 to specifically target the high-spenders identified in the analysis.

### 📦 Inventory Planning

**Stock for Volume, Prep for Value:** The kitchen must prioritize stock for **Asian ingredients** (highest volume) to prevent stockouts, but ensure the **Italian station** is staffed with the most experienced cooks to protect the highest revenue stream.
