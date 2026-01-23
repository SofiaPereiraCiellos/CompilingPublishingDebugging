# AL Debugging Guide - Simple Sales Discount Example

Quick guide for practicing AL debugging with a practical sales order discount scenario.

## 🎯 What This Demonstrates

- **Setting Breakpoints** - Pause execution at specific lines
- **Conditional Breakpoints** - Break only when conditions are met (e.g., `SalesLine."No." = '1896-S'`)
- **Watch Window** - Monitor variables and record fields in real-time
- **Debug Console** - Evaluate expressions during debugging
- **Event Subscribers** - Debug event-driven code

## 🚀 Quick Start

1. **Start Debugging**: Press `F5` in VS Code
2. **Open Page**: Search for "Sales Order Debug Helper" in Business Central
3. **Select Order**: Choose any sales order with items
4. **Set Breakpoints**: Open [SalesLineProcessor.Codeunit.al](src/SalesLineProcessor.Codeunit.al) and click line numbers to set breakpoints
5. **Run**: Click "Apply Volume Discounts" and watch the debugger break

## 📍 Key Debugging Locations

### 1. Basic Breakpoint
**File**: [SalesLineProcessor.Codeunit.al](src/SalesLineProcessor.Codeunit.al)  
**Line 18**: `if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then`

**Try this:**
- Set breakpoint on line 18
- Run "Apply Volume Discounts"
- When it breaks, hover over `SalesHeader` to see values
- Add `SalesHeader."No."` to Watch window

### 2. Conditional Breakpoint - Specific Item
**File**: [SalesLineProcessor.Codeunit.al](src/SalesLineProcessor.Codeunit.al)  
**Line 27**: `if SalesLine.FindSet() then`

**Try this:**
- Right-click line 27 → Edit Breakpoint → Add Condition
- Enter: `SalesLine."No." = '1896-S'` (use your item number)
- Debugger only breaks for that specific item

### 3. Conditional Breakpoint - Discount Applied
**File**: [SalesLineProcessor.Codeunit.al](src/SalesLineProcessor.Codeunit.al)  
**Line 35**: `if DiscountPct > 0 then`

**Try this:**
- Set conditional breakpoint: `DiscountPct > 0`
- Debugger only breaks when discount applies
- Add `DiscountPct` to Watch window

### 4. Event Subscriber - Quantity Change
**File**: [SalesOrderEventSubscriber.Codeunit.al](src/SalesOrderEventSubscriber.Codeunit.al)  
**Line 12**: `if Rec.Type <> Rec.Type::Item then`

**Try this:**
- Set conditional breakpoint: `Rec.Quantity > 50`
- Open any sales order in BC
- Change quantity to 60 → debugger breaks
- Compare `Rec` (new) vs `xRec` (old) in Watch window

## 🔍 Debug Console Examples

While stopped at a breakpoint, use Debug Console (View → Debug Console):

```al
// Simple expressions
Quantity
DiscountPct

// Calculations
Quantity * 2
Item.Inventory - SalesLine.Quantity

// Record fields
SalesLine."Line Amount"
Item.Description
```

## 📊 Watch Window Examples

Add these to Watch window (Debug → Add Watch):

- `SalesLine` - Expand to see all fields
- `SalesLine.Quantity`
- `DiscountPct`
- `Item.Inventory`
- `Rec.Quantity - xRec.Quantity` (in event subscriber)

## 💡 Debugging Flow

1. **Set Breakpoint** → Click line number in code
2. **Run Action** → Click "Apply Volume Discounts" in BC
3. **Debugger Breaks** → Execution pauses at breakpoint
4. **Inspect Values** → Hover variables or use Watch
5. **Step Through**:
   - `F10` - Step Over (execute line, don't go into methods)
   - `F11` - Step Into (enter method to debug it)
   - `Shift+F11` - Step Out (exit current method)
   - `F5` - Continue (run to next breakpoint)

## 🎓 Practice Scenarios

### Scenario 1: Track Discount Calculation
1. Set breakpoint at line 50 in `GetVolumeDiscount`
2. Add `Quantity` to Watch
3. Step through the case statement
4. See which discount tier applies

### Scenario 2: Debug Specific Item
1. Set conditional breakpoint: `SalesLine."No." = 'YOUR-ITEM'`
2. Process an order with multiple items
3. Debugger only breaks for your item

### Scenario 3: Monitor Inventory Check
1. Open [SalesOrderEventSubscriber.Codeunit.al](src/SalesOrderEventSubscriber.Codeunit.al)
2. Set breakpoint at line 20
3. Open sales order, change quantity to 100
4. Watch inventory validation in debugger

## 📝 Business Logic

**Volume Discounts:**
- 50+ units: 10% discount
- 20-49 units: 5% discount
- Less than 20: No discount

**Inventory Validation:**
- Warns when ordering more than available inventory
- Only triggers for quantities > 50

## 🔧 Files

- [SalesLineProcessor.Codeunit.al](src/SalesLineProcessor.Codeunit.al) - Discount logic
- [SalesOrderEventSubscriber.Codeunit.al](src/SalesOrderEventSubscriber.Codeunit.al) - Event subscriber
- [SalesOrderDebugPage.Page.al](src/SalesOrderDebugPage.Page.al) - Helper page

---

**Happy Debugging! 🐛**
