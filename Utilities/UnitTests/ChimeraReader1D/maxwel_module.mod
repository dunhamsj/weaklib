V28 :0x14 maxwel_module
38 ../../../External/LS/MAXWEL_MODULE.f90 S622 0
03/12/2015  00:11:49
use wlkindmodule private
enduse
D 56 21 9 2 24 23 0 0 0 0 0
 0 14 3 3 14 14
 0 16 14 3 16 16
D 59 21 9 2 24 23 0 0 0 0 0
 0 14 3 3 14 14
 0 16 14 3 16 16
D 62 21 9 1 3 16 0 0 0 0 0
 0 16 3 3 16 16
D 65 21 9 1 3 16 0 0 0 0 0
 0 16 3 3 16 16
D 68 21 9 2 41 40 0 0 0 0 0
 0 18 3 3 18 18
 0 16 18 3 16 16
D 71 21 9 2 41 40 0 0 0 0 0
 0 18 3 3 18 18
 0 16 18 3 16 16
S 622 24 0 0 0 6 1 0 5031 5 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 0 0 0 120 0 0 0 0 0 0 0 0 6 0 0 0 0 0 0 maxwel_module
S 624 23 0 0 0 9 627 622 5058 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 double
R 627 16 1 wlkindmodule dp
S 628 16 1 0 0 6 630 622 5068 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 201 14 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 numtmp
S 629 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 201 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 630 16 1 0 0 6 632 622 5075 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 49 16 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 numye
S 631 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 49 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 632 16 1 0 0 6 634 622 5081 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 101 18 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 nbpnts
S 633 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 634 16 0 0 0 6 636 622 5088 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 51 20 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 numlow
S 635 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 51 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 636 16 0 0 0 6 649 622 5095 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 51 20 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 numhi
S 637 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 9849 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 638 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 202 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 639 7 4 0 4 56 640 622 5101 800004 100 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 brylow
S 640 7 4 0 4 59 641 622 5108 800004 100 A 0 0 0 0 B 0 0 0 0 0 78800 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 bryhi
S 641 6 4 0 0 9 642 622 5114 4 0 A 0 0 0 0 B 0 0 0 0 0 157592 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lowdns
S 642 6 4 0 0 9 643 622 5121 4 0 A 0 0 0 0 B 0 0 0 0 0 157600 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 hidns
S 643 6 4 0 0 9 644 622 5127 4 0 A 0 0 0 0 B 0 0 0 0 0 157608 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 dns_1
S 644 6 4 0 0 9 645 622 5133 4 0 A 0 0 0 0 B 0 0 0 0 0 157616 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 dns_2
S 645 6 4 0 0 9 646 622 5139 4 0 A 0 0 0 0 B 0 0 0 0 0 157624 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 dnl_dt
S 646 6 4 0 0 9 647 622 5146 4 0 A 0 0 0 0 B 0 0 0 0 0 157632 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 dnh_dt
S 647 6 4 0 0 9 648 622 5153 4 0 A 0 0 0 0 B 0 0 0 0 0 157640 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 dnl_dy
S 648 6 4 0 0 9 658 622 5160 4 0 A 0 0 0 0 B 0 0 0 0 0 157648 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 dnh_dy
S 649 16 0 0 0 9 652 622 5167 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 651 26 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lnlow
S 651 3 0 0 0 9 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 -1071524086 1030792151 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9
S 652 16 0 0 0 9 655 622 5173 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 654 29 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lnhi
S 654 3 0 0 0 9 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 -1074958173 -687194767 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9
S 655 16 0 0 0 9 665 622 5178 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 657 32 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lncut
S 657 3 0 0 0 9 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 -1073259480 -171798692 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9
S 658 6 4 0 0 9 659 622 5184 4 0 A 0 0 0 0 B 0 0 0 0 0 157656 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lnmins
S 659 6 4 0 0 9 660 622 5191 4 0 A 0 0 0 0 B 0 0 0 0 0 157664 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lnplus
S 660 6 4 0 0 9 661 622 5198 4 0 A 0 0 0 0 B 0 0 0 0 0 157672 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 logbry
S 661 6 4 0 0 9 662 622 5205 4 0 A 0 0 0 0 B 0 0 0 0 0 157680 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 logbch
S 662 6 4 0 0 9 663 622 5212 4 0 A 0 0 0 0 B 0 0 0 0 0 157688 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 dltln1
S 663 6 4 0 0 9 664 622 5219 4 0 A 0 0 0 0 B 0 0 0 0 0 157696 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 dltln2
S 664 6 4 0 0 9 671 622 5226 4 0 A 0 0 0 0 B 0 0 0 0 0 157704 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lnfrac
S 665 16 0 0 0 9 667 622 5233 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 666 34 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 ylow
S 666 3 0 0 0 9 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 1069841121 1202590843 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9
S 667 16 0 0 0 9 669 622 5238 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 668 36 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 yhi
S 668 3 0 0 0 9 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 1071665643 -2061584302 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9
S 669 16 0 0 0 9 681 622 5242 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 670 38 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 y_cut
S 670 3 0 0 0 9 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 1069799178 1030792151 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9
S 671 6 4 0 0 9 672 622 5248 4 0 A 0 0 0 0 B 0 0 0 0 0 157712 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 tchk_b
S 672 6 4 0 0 9 673 622 5255 4 0 A 0 0 0 0 B 0 0 0 0 0 157720 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 tchk_n
S 673 6 4 0 0 9 674 622 5262 4 0 A 0 0 0 0 B 0 0 0 0 0 157728 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 t_mxwl
S 674 6 4 0 0 9 675 622 5269 4 0 A 0 0 0 0 B 0 0 0 0 0 157736 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 d_mxwl
S 675 7 4 0 4 62 676 622 5276 800004 100 A 0 0 0 0 B 0 0 0 0 0 157744 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 t_h
S 676 7 4 0 4 65 679 622 5280 800004 100 A 0 0 0 0 B 0 0 0 0 0 158144 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 d_h
S 677 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 4949 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 678 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 102 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 679 7 4 0 4 68 680 622 2832 800004 100 A 0 0 0 0 B 0 0 0 0 0 158544 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lbound
S 680 7 4 0 4 71 683 622 2839 800004 100 A 0 0 0 0 B 0 0 0 0 0 198144 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 ubound
S 681 16 0 0 0 9 0 622 5284 800004 400000 A 0 0 0 0 B 0 0 0 0 0 0 0 0 682 42 0 0 0 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 mindns
S 682 3 0 0 0 9 0 1 0 0 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 1037794527 -640172613 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9
S 683 6 4 0 0 9 684 622 5291 4 0 A 0 0 0 0 B 0 0 0 0 0 237736 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 newdns
S 684 6 4 0 0 9 685 622 5298 4 0 A 0 0 0 0 B 0 0 0 0 0 237744 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 t_low
S 685 6 4 0 0 9 686 622 5304 4 0 A 0 0 0 0 B 0 0 0 0 0 237752 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 t_hi
S 686 6 4 0 0 9 687 622 5309 4 0 A 0 0 0 0 B 0 0 0 0 0 237760 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 tfrac
S 687 6 4 0 0 9 688 622 5315 4 0 A 0 0 0 0 B 0 0 0 0 0 237768 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 y_low
S 688 6 4 0 0 9 689 622 5321 4 0 A 0 0 0 0 B 0 0 0 0 0 237776 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 y_low2
S 689 6 4 0 0 9 690 622 5328 4 0 A 0 0 0 0 B 0 0 0 0 0 237784 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 y_hi
S 690 6 4 0 0 9 691 622 5333 4 0 A 0 0 0 0 B 0 0 0 0 0 237792 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 y_hi2
S 691 6 4 0 0 9 692 622 5339 4 0 A 0 0 0 0 B 0 0 0 0 0 237800 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 yfrac
S 692 6 4 0 0 9 693 622 5345 4 0 A 0 0 0 0 B 0 0 0 0 0 237808 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 ych
S 693 6 4 0 0 9 694 622 5349 4 0 A 0 0 0 0 B 0 0 0 0 0 237816 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 ycut
S 694 6 4 0 0 9 695 622 5354 4 0 A 0 0 0 0 B 0 0 0 0 0 237824 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lnl
S 695 6 4 0 0 9 696 622 5358 4 0 A 0 0 0 0 B 0 0 0 0 0 237832 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lnh
S 696 6 4 0 0 9 697 622 5362 4 0 A 0 0 0 0 B 0 0 0 0 0 237840 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 lnc
S 697 6 4 0 0 9 698 622 5366 4 0 A 0 0 0 0 B 0 0 0 0 0 237848 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 yminus
S 698 6 4 0 0 9 699 622 5373 4 0 A 0 0 0 0 B 0 0 0 0 0 237856 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 yplus
S 699 6 4 0 0 9 700 622 5379 4 0 A 0 0 0 0 B 0 0 0 0 0 237864 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 yintrp
S 700 6 4 0 0 9 701 622 5386 4 0 A 0 0 0 0 B 0 0 0 0 0 237872 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 tminus
S 701 6 4 0 0 9 702 622 5393 4 0 A 0 0 0 0 B 0 0 0 0 0 237880 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 tplus
S 702 6 4 0 0 9 703 622 5399 4 0 A 0 0 0 0 B 0 0 0 0 0 237888 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 tintrp
S 703 6 4 0 0 9 704 622 5406 4 0 A 0 0 0 0 B 0 0 0 0 0 237896 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 delt_y
S 704 6 4 0 0 9 711 622 5413 4 0 A 0 0 0 0 B 0 0 0 0 0 237904 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 delt_t
S 705 6 4 0 0 6 706 622 5420 4 0 A 0 0 0 0 B 0 0 0 0 0 0 0 0 0 0 0 0 727 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 i_mxwl
S 706 6 4 0 0 6 707 622 5427 4 0 A 0 0 0 0 B 0 0 0 0 0 4 0 0 0 0 0 0 727 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 j_mxwl
S 707 6 4 0 0 6 708 622 5434 4 0 A 0 0 0 0 B 0 0 0 0 0 8 0 0 0 0 0 0 727 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 i_bd
S 708 6 4 0 0 6 709 622 5439 4 0 A 0 0 0 0 B 0 0 0 0 0 12 0 0 0 0 0 0 727 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 i_bndy
S 709 6 4 0 0 6 710 622 5446 4 0 A 0 0 0 0 B 0 0 0 0 0 16 0 0 0 0 0 0 727 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 j_bd
S 710 6 4 0 0 6 1 622 5451 4 0 A 0 0 0 0 B 0 0 0 0 0 20 0 0 0 0 0 0 727 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 j_bndy
S 711 6 4 0 0 9 712 622 5458 4 0 A 0 0 0 0 B 0 0 0 0 0 237912 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 mutild
S 712 6 4 0 0 9 713 622 5465 4 0 A 0 0 0 0 B 0 0 0 0 0 237920 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 mutlow
S 713 6 4 0 0 9 714 622 5472 4 0 A 0 0 0 0 B 0 0 0 0 0 237928 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 muthi
S 714 6 4 0 0 9 715 622 5478 4 0 A 0 0 0 0 B 0 0 0 0 0 237936 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 prtild
S 715 6 4 0 0 9 716 622 5485 4 0 A 0 0 0 0 B 0 0 0 0 0 237944 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 prlow
S 716 6 4 0 0 9 717 622 5491 4 0 A 0 0 0 0 B 0 0 0 0 0 237952 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 prhi
S 717 6 4 0 0 9 718 622 5496 4 0 A 0 0 0 0 B 0 0 0 0 0 237960 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 muhlow
S 718 6 4 0 0 9 719 622 5503 4 0 A 0 0 0 0 B 0 0 0 0 0 237968 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 muhhi
S 719 6 4 0 0 9 720 622 5509 4 0 A 0 0 0 0 B 0 0 0 0 0 237976 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 muelow
S 720 6 4 0 0 9 721 622 5516 4 0 A 0 0 0 0 B 0 0 0 0 0 237984 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 muehi
S 721 6 4 0 0 9 722 622 5522 4 0 A 0 0 0 0 B 0 0 0 0 0 237992 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 s_low
S 722 6 4 0 0 9 723 622 5528 4 0 A 0 0 0 0 B 0 0 0 0 0 238000 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 s_hi
S 723 6 4 0 0 9 724 622 5533 4 0 A 0 0 0 0 B 0 0 0 0 0 238008 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 f_low
S 724 6 4 0 0 9 725 622 5539 4 0 A 0 0 0 0 B 0 0 0 0 0 238016 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 f_hi
S 725 6 4 0 0 9 1 622 5544 4 0 A 0 0 0 0 B 0 0 0 0 0 238024 0 0 0 0 0 0 726 0 0 0 0 0 0 0 0 0 0 622 0 0 0 0 phasef
S 726 11 0 0 4 9 1 622 5551 40800000 805000 A 0 0 0 0 B 0 0 0 0 0 238032 0 0 639 725 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 _maxwel_module$2
S 727 11 0 0 0 9 726 622 5568 40800000 805000 A 0 0 0 0 B 0 0 0 0 0 24 0 0 705 710 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 _maxwel_module$0
A 14 2 0 0 0 6 629 0 0 0 14 0 0 0 0 0 0 0 0 0
A 16 2 0 0 0 6 631 0 0 0 16 0 0 0 0 0 0 0 0 0
A 18 2 0 0 0 6 633 0 0 0 18 0 0 0 0 0 0 0 0 0
A 20 2 0 0 0 6 635 0 0 0 20 0 0 0 0 0 0 0 0 0
A 23 2 0 0 0 6 637 0 0 0 23 0 0 0 0 0 0 0 0 0
A 24 2 0 0 0 6 638 0 0 0 24 0 0 0 0 0 0 0 0 0
A 26 2 0 0 0 9 651 0 0 0 26 0 0 0 0 0 0 0 0 0
A 29 2 0 0 0 9 654 0 0 0 29 0 0 0 0 0 0 0 0 0
A 32 2 0 0 0 9 657 0 0 0 32 0 0 0 0 0 0 0 0 0
A 34 2 0 0 0 9 666 0 0 0 34 0 0 0 0 0 0 0 0 0
A 36 2 0 0 0 9 668 0 0 0 36 0 0 0 0 0 0 0 0 0
A 38 2 0 0 0 9 670 0 0 0 38 0 0 0 0 0 0 0 0 0
A 40 2 0 0 0 6 677 0 0 0 40 0 0 0 0 0 0 0 0 0
A 41 2 0 0 0 6 678 0 0 0 41 0 0 0 0 0 0 0 0 0
A 42 2 0 0 0 9 682 0 0 0 42 0 0 0 0 0 0 0 0 0
Z
Z