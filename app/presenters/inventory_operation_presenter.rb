# encoding: utf-8
# author: Boris Barroso
# email: boriscyber@gmail.com
class InventoryOperationPresenter < BasePresenter
  attr_accessor :transaction
  presents :inventory_operation

  def select_store_title
    case
    when (transaction.is_a?(Income) and inventory_operation.out?)
      "<span class='dark_green'>Entrega</span>".html_safe
    when (transaction.is_a?(Income) and inventory_operation.in?)
      "<span class='red'>Devolución</span>".html_safe
    when (transaction.is_a?(Buy) and inventory_operation.in?)
      "<span class='dark_green'>Recojo</span>".html_safe
    when (transaction.is_a?(Buy) and inventory_operation.out?)
      "<span class='red'>Devolución</span>".html_safe
    end
  end

  def transaction_title
    "#{select_store_title} #{transaction}".html_safe
  end

  def title
    case
    when( inventory_operation.transaction_id.present? and transaction.is_a?(Income) and inventory_operation.out? )
      "<span class='dark_green'>Entrega</span> #{transaction}".html_safe
    when( inventory_operation.transaction_id.present? and transaction.is_a?(Income) and inventory_operation.in? )
      "<span class='red'>Devolución</span> #{transaction}".html_safe
    when( inventory_operation.transaction_id.present? and transaction.is_a?(Buy) and inventory_operation.in? )
      "<span class='dark_green'>Recojo</span> #{transaction}".html_safe
    when( inventory_operation.transaction_id.present? and transaction.is_a?(Income) and inventory_operation.out? )
      "<span class='red'>Devolución</span> #{transaction}".html_safe
    when inventory_operation.in?
      "<span class='dark_green'>Ingreso</span> a almacen #{inventory_operation.store}".html_safe
    when inventory_operation.out?
      "<span class='red'>Egreso</span> a almacen #{inventory_operation.store}".html_safe
    end
  end

  def link_related
    if inventory_operation.transference_id.present?
      trans = inventory_operation.transference
      txt = trans.operation == "transout" ? "a" : "desde"
      h.link_to "Transferencia #{txt} #{trans.store_to}", trans, :title => "Transferencia a #{trans}"
    elsif inventory_operation.contact_id.present?
      cont = inventory_operation.contact
      h.link_to cont, cont, :title => "Contacto"
    end
  end
end

