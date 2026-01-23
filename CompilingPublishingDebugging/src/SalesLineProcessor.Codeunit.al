/// <summary>
/// Codeunit for applying volume discounts to sales lines.
/// DEBUGGING SHOWCASE: Practice breakpoints, watch, and console.
/// </summary>
codeunit 80100 "Sales Line Processor"
{
    /// <summary>
    /// Applies volume discounts to all lines in a sales order.
    /// DEBUGGING TIP: Set a breakpoint on line 14 to start debugging.
    /// </summary>
    procedure ApplyVolumeDiscounts(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        DiscountPct: Decimal;
        LineCount: Integer;
    begin
        // BREAKPOINT HERE: Set a breakpoint to inspect SalesHeader
        // Add SalesHeader to Watch window
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            Error('Only sales orders are supported');

        LineCount := 0;

        // CONDITIONAL BREAKPOINT: Set condition: SalesLine."No." = '1896-S'
        // This breaks only for a specific item number
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                if SalesLine.Type = SalesLine.Type::Item then begin
                    // Add SalesLine to Watch to see all fields
                    DiscountPct := GetVolumeDiscount(SalesLine.Quantity);

                    if DiscountPct > 0 then begin
                        SalesLine.Validate("Line Discount %", DiscountPct);
                        SalesLine.Modify(true);
                        LineCount += 1;
                    end;
                end;
            until SalesLine.Next() = 0;

        Message('Applied discounts to %1 lines', LineCount);
    end;

    /// <summary>
    /// Returns discount percentage based on quantity ordered.
    /// DEBUGGING TIP: Step into (F11) to see discount calculation.
    /// </summary>
    local procedure GetVolumeDiscount(Quantity: Decimal): Decimal
    begin
        // BREAKPOINT HERE: Set a breakpoint to inspect quantity
        // Use Debug Console to evaluate: Quantity * 2 or Quantity >= 50

        case true of
            Quantity >= 50:
                exit(10);  // 10% discount for 50+ units
            Quantity >= 20:
                exit(5);   // 5% discount for 20-49 units
            else
                exit(0);   // No discount for less than 20
        end;
    end;
}
