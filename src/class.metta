(: M (-> $T Type))
(: mkM (-> $T (M $T)))

(: bind (-> (M $T) (-> $T $U) (M $U))) 
(= (bind (mkM $val) $func) (mkM ($func $val)))

(= ((mkM $val) $func) (mkM ($func $val)))
(= ((mkM $val) effect $func) (let $_ ($func $val) (mkM $val)))

(: add1 (-> Number Number))
(= (add1 $x) (+ $x 1))

(= (m) (mkM 42))
!(assertEqual ((m) effect add1) (mkM 42))
!(assertEqual ((m) add1) (mkM 43))


;-------

(= (add-to-self $m $x) (add-atom &self ($m $x)))
(= ((add-to-self $m) $x) (add-to-self $m $x))

(= ($m) (mkM (match &self ($m $f) $f)))
(= (from ($s to $t) $func) ((($s) $func) effect (add-to-self $t)))

(e 1)
(e 2)
(e 5)

!(from (e to e1) add1)
!(e)
!(e1)

;--------

(= (remove-from-self $m $x) (remove-atom &self ($m $x)))
(= ((remove-from-self $m) $x) (remove-from-self $m $x))
(= (to $s $func) (((($s) effect (remove-from-self $s)) $func) effect (add-to-self $s))) 

!(to e1 add1)
;---------

;when you want to access the values directly
(= (unwrap (mkM $b)) $b)
(= (gimme $s) (unwrap ($s)))
!(gimme e1)

(s 1)
(= ((le $x) $y) (is (> $x $y)))
(= ($expr (is $bool)) (if $bool $expr ()))

;-- below broken
(= ((increase-until $n) $x) (increase $x until $n))
(= (increase $s until $n) ((((to $s add1) (le $n)) $s) (increase-until $n))) 
(= (wrap $x) ($x))

!(increase s until 3)
